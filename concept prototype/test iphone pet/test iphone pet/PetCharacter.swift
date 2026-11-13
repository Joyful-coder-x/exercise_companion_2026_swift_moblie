import Observation
import SwiftUI

enum PetExpression: String, Codable, Hashable, CaseIterable {
    case lookingLeft
    case resting
    case lookingRight

    var pupilOffset: CGFloat {
        switch self {
        case .lookingLeft: -4
        case .resting: 0
        case .lookingRight: 4
        }
    }

    var label: LocalizedStringResource {
        switch self {
        case .lookingLeft: "Looking left"
        case .resting: "Resting"
        case .lookingRight: "Looking right"
        }
    }
}

struct PetMotionSnapshot: Equatable {
    var position: CGPoint
    var pupilOffset: CGSize
}

@MainActor
@Observable
final class PetMotionModel {
    private var start = PetMotionSnapshot(
        position: CGPoint(x: 0.5, y: 0.5),
        pupilOffset: .zero
    )
    private var target = PetMotionSnapshot(
        position: CGPoint(x: 0.5, y: 0.5),
        pupilOffset: .zero
    )
    private var transitionStart = Date.now
    private var transitionDuration = 1.0

    func snapshot(at date: Date = .now) -> PetMotionSnapshot {
        let elapsed = date.timeIntervalSince(transitionStart)
        let progress = max(0, min(1, elapsed / transitionDuration))
        let eased = progress * progress * (3 - 2 * progress)

        return PetMotionSnapshot(
            position: CGPoint(
                x: interpolate(from: start.position.x, to: target.position.x, progress: eased),
                y: interpolate(from: start.position.y, to: target.position.y, progress: eased)
            ),
            pupilOffset: CGSize(
                width: interpolate(
                    from: start.pupilOffset.width,
                    to: target.pupilOffset.width,
                    progress: eased
                ),
                height: interpolate(
                    from: start.pupilOffset.height,
                    to: target.pupilOffset.height,
                    progress: eased
                )
            )
        )
    }

    func animateUntilCancelled() async {
        while !Task.isCancelled {
            let delay = Double.random(in: 1...3)

            do {
                try await Task.sleep(for: .seconds(delay))
            } catch {
                return
            }

            start = snapshot()
            target = PetMotionSnapshot(
                position: CGPoint(
                    x: Double.random(in: 0.18...0.82),
                    y: Double.random(in: 0.22...0.78)
                ),
                pupilOffset: CGSize(
                    width: Double.random(in: -5...5),
                    height: Double.random(in: -3...3)
                )
            )
            transitionStart = .now
            transitionDuration = min(delay, 1.4)
        }
    }

    private func interpolate(from: CGFloat, to: CGFloat, progress: Double) -> CGFloat {
        from + (to - from) * progress
    }
}

struct PetFace: View {
    let pupilOffset: CGSize

    var body: some View {
        ZStack {
            Circle()
                .fill(.orange.gradient)

            HStack(spacing: 14) {
                PetEye(pupilOffset: pupilOffset)
                PetEye(pupilOffset: pupilOffset)
            }
            .offset(y: -6)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Orange ball character")
    }
}

private struct PetEye: View {
    let pupilOffset: CGSize

    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 28, height: 34)

            Circle()
                .fill(.black)
                .frame(width: 11, height: 11)
                .offset(pupilOffset)
        }
    }
}
