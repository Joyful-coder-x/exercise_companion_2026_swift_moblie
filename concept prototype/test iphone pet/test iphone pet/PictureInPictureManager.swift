import AVFoundation
import AVKit
import CoreMedia
import Observation
import SwiftUI
import UIKit

@MainActor
@Observable
final class PictureInPictureManager: NSObject,
    AVPictureInPictureControllerDelegate,
    AVPictureInPictureSampleBufferPlaybackDelegate {
    private(set) var isReady = false
    private(set) var isActive = false
    private(set) var status = String(localized: "Preparing live frames…")

    let displayLayer = AVSampleBufferDisplayLayer()

    private var motionModel: PetMotionModel?
    private var pictureInPictureController: AVPictureInPictureController?
    private var frameTimer: DispatchSourceTimer?
    private var isPlaying = true
    private var frameNumber: Int64 = 0

    override init() {
        super.init()
        displayLayer.videoGravity = .resizeAspect
        configureAudioSession()
    }

    func connect(to motionModel: PetMotionModel) {
        guard self.motionModel == nil else { return }
        self.motionModel = motionModel
        startFrameTimer()
    }

    func attachDisplayLayer() {
        guard pictureInPictureController == nil else { return }
        guard AVPictureInPictureController.isPictureInPictureSupported() else {
            status = String(localized: "PiP is not supported on this device.")
            return
        }

        let source = AVPictureInPictureController.ContentSource(
            sampleBufferDisplayLayer: displayLayer,
            playbackDelegate: self
        )
        let controller = AVPictureInPictureController(contentSource: source)
        controller.delegate = self
        controller.requiresLinearPlayback = true
        pictureInPictureController = controller
    }

    func togglePictureInPicture() {
        guard let controller = pictureInPictureController else { return }

        if controller.isPictureInPictureActive {
            controller.stopPictureInPicture()
        } else if controller.isPictureInPicturePossible {
            isPlaying = true
            controller.invalidatePlaybackState()
            controller.startPictureInPicture()
        } else {
            status = String(localized: "PiP is not ready yet. Wait for the live preview, then try again.")
        }
    }

    func pictureInPictureControllerDidStartPictureInPicture(
        _ pictureInPictureController: AVPictureInPictureController
    ) {
        isActive = true
        status = String(localized: "Live Picture in Picture is running.")
    }

    func pictureInPictureControllerDidStopPictureInPicture(
        _ pictureInPictureController: AVPictureInPictureController
    ) {
        isActive = false
        status = String(localized: "Picture in Picture stopped.")
    }

    func pictureInPictureController(
        _ pictureInPictureController: AVPictureInPictureController,
        failedToStartPictureInPictureWithError error: any Error
    ) {
        status = error.localizedDescription
    }

    func pictureInPictureController(
        _ pictureInPictureController: AVPictureInPictureController,
        setPlaying playing: Bool
    ) {
        isPlaying = playing
        pictureInPictureController.invalidatePlaybackState()
    }

    func pictureInPictureControllerTimeRangeForPlayback(
        _ pictureInPictureController: AVPictureInPictureController
    ) -> CMTimeRange {
        CMTimeRange(start: .zero, duration: .positiveInfinity)
    }

    func pictureInPictureControllerIsPlaybackPaused(
        _ pictureInPictureController: AVPictureInPictureController
    ) -> Bool {
        !isPlaying
    }

    func pictureInPictureController(
        _ pictureInPictureController: AVPictureInPictureController,
        didTransitionToRenderSize newRenderSize: CMVideoDimensions
    ) {
    }

    func pictureInPictureController(
        _ pictureInPictureController: AVPictureInPictureController,
        skipByInterval skipInterval: CMTime,
        completion completionHandler: @escaping @Sendable () -> Void
    ) {
        completionHandler()
    }

    func pictureInPictureControllerShouldProhibitBackgroundAudioPlayback(
        _ pictureInPictureController: AVPictureInPictureController
    ) -> Bool {
        false
    }

    private func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback)
            try session.setActive(true)
        } catch {
            status = error.localizedDescription
        }
    }

    private func startFrameTimer() {
        guard frameTimer == nil else { return }

        let timer = DispatchSource.makeTimerSource(queue: .main)
        timer.schedule(deadline: .now(), repeating: 1.0 / 30.0, leeway: .milliseconds(3))
        timer.setEventHandler { [weak self] in
            self?.enqueueCurrentFrame()
        }
        frameTimer = timer
        timer.resume()
    }

    private func enqueueCurrentFrame() {
        guard isPlaying, let motionModel else { return }

        if displayLayer.status == .failed {
            displayLayer.flush()
        }

        guard displayLayer.isReadyForMoreMediaData else { return }

        let snapshot = motionModel.snapshot()
        guard let sampleBuffer = PetSampleBufferRenderer.makeSampleBuffer(
            snapshot: snapshot,
            frameNumber: frameNumber
        ) else {
            status = String(localized: "Could not create a live video frame.")
            return
        }

        displayLayer.enqueue(sampleBuffer)
        frameNumber += 1

        if !isReady {
            isReady = true
            status = String(localized: "Live preview ready. Tap Start PiP.")
        }
    }
}

struct PiPPlayerView: UIViewRepresentable {
    let manager: PictureInPictureManager
    let motionModel: PetMotionModel

    func makeUIView(context: Context) -> SampleBufferContainerView {
        let view = SampleBufferContainerView()
        view.displayLayer = manager.displayLayer
        manager.connect(to: motionModel)
        manager.attachDisplayLayer()
        return view
    }

    func updateUIView(_ uiView: SampleBufferContainerView, context: Context) {
        uiView.displayLayer = manager.displayLayer
    }
}

final class SampleBufferContainerView: UIView {
    var displayLayer: AVSampleBufferDisplayLayer? {
        didSet {
            oldValue?.removeFromSuperlayer()
            if let displayLayer {
                layer.addSublayer(displayLayer)
                setNeedsLayout()
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        displayLayer?.frame = bounds
    }
}

private enum PetSampleBufferRenderer {
    private static let width = 640
    private static let height = 360
    private static let frameRate: Int32 = 30

    static func makeSampleBuffer(
        snapshot: PetMotionSnapshot,
        frameNumber: Int64
    ) -> CMSampleBuffer? {
        var optionalPixelBuffer: CVPixelBuffer?
        let attributes: [CFString: Any] = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true,
            kCVPixelBufferIOSurfacePropertiesKey: [:]
        ]

        let pixelBufferStatus = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32BGRA,
            attributes as CFDictionary,
            &optionalPixelBuffer
        )
        guard pixelBufferStatus == kCVReturnSuccess,
              let pixelBuffer = optionalPixelBuffer else {
            return nil
        }

        draw(snapshot: snapshot, into: pixelBuffer)

        var optionalDescription: CMVideoFormatDescription?
        guard CMVideoFormatDescriptionCreateForImageBuffer(
            allocator: kCFAllocatorDefault,
            imageBuffer: pixelBuffer,
            formatDescriptionOut: &optionalDescription
        ) == noErr,
              let description = optionalDescription else {
            return nil
        }

        var timing = CMSampleTimingInfo(
            duration: CMTime(value: 1, timescale: frameRate),
            presentationTimeStamp: CMTime(value: frameNumber, timescale: frameRate),
            decodeTimeStamp: .invalid
        )
        var optionalSampleBuffer: CMSampleBuffer?
        guard CMSampleBufferCreateReadyWithImageBuffer(
            allocator: kCFAllocatorDefault,
            imageBuffer: pixelBuffer,
            formatDescription: description,
            sampleTiming: &timing,
            sampleBufferOut: &optionalSampleBuffer
        ) == noErr,
              let sampleBuffer = optionalSampleBuffer else {
            return nil
        }

        CMSetAttachment(
            sampleBuffer,
            key: kCMSampleAttachmentKey_DisplayImmediately,
            value: kCFBooleanTrue,
            attachmentMode: kCMAttachmentMode_ShouldPropagate
        )
        return sampleBuffer
    }

    private static func draw(snapshot: PetMotionSnapshot, into pixelBuffer: CVPixelBuffer) {
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, []) }

        guard let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer),
              let context = CGContext(
                data: baseAddress,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue
                    | CGImageAlphaInfo.premultipliedFirst.rawValue
              ) else {
            return
        }

        context.setFillColor(UIColor(red: 0.08, green: 0.11, blue: 0.18, alpha: 1).cgColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))

        let center = CGPoint(
            x: snapshot.position.x * CGFloat(width),
            y: (1 - snapshot.position.y) * CGFloat(height)
        )
        let radius: CGFloat = 48
        context.setFillColor(UIColor.orange.cgColor)
        context.fillEllipse(
            in: CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            )
        )

        for eyeOffsetX in [-18.0, 18.0] {
            let eyeCenter = CGPoint(x: center.x + eyeOffsetX, y: center.y + 10)
            context.setFillColor(UIColor.white.cgColor)
            context.fillEllipse(
                in: CGRect(x: eyeCenter.x - 11, y: eyeCenter.y - 14, width: 22, height: 28)
            )

            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(
                in: CGRect(
                    x: eyeCenter.x - 5 + snapshot.pupilOffset.width,
                    y: eyeCenter.y - 5 - snapshot.pupilOffset.height,
                    width: 10,
                    height: 10
                )
            )
        }
    }
}
