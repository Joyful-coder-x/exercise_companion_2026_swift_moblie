import SwiftUI

struct ContentView: View {
    @State private var motionModel = PetMotionModel()
    @State private var pipManager = PictureInPictureManager()
    @State private var liveActivityManager = LiveActivityManager()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                InAppPetTest(motionModel: motionModel)
                PictureInPictureTest(
                    manager: pipManager,
                    motionModel: motionModel
                )
                LiveActivityTest(manager: liveActivityManager)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .task {
            await motionModel.animateUntilCancelled()
        }
    }
}

private struct InAppPetTest: View {
    let motionModel: PetMotionModel

    var body: some View {
        TestCard(title: "1. In-App Animation") {
            TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { context in
                let snapshot = motionModel.snapshot(at: context.date)

                GeometryReader { geometry in
                    PetFace(pupilOffset: snapshot.pupilOffset)
                        .frame(width: 92, height: 92)
                        .position(
                            x: snapshot.position.x * geometry.size.width,
                            y: snapshot.position.y * geometry.size.height
                        )
                }
            }
            .frame(height: 260)
            .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 18))

            Text("The app and PiP now render the same live random motion state.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

private struct PictureInPictureTest: View {
    let manager: PictureInPictureManager
    let motionModel: PetMotionModel

    var body: some View {
        TestCard(title: "2. Picture in Picture") {
            PiPPlayerView(manager: manager, motionModel: motionModel)
                .frame(height: 150)
                .background(.black, in: RoundedRectangle(cornerRadius: 18))
                .clipShape(RoundedRectangle(cornerRadius: 18))

            Button(manager.isActive ? "Stop PiP" : "Start PiP") {
                manager.togglePictureInPicture()
            }
            .buttonStyle(.borderedProminent)
            .disabled(!manager.isReady)

            Text(manager.status)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

private struct LiveActivityTest: View {
    let manager: LiveActivityManager

    var body: some View {
        TestCard(title: "3. Live Activity") {
            PetFace(pupilOffset: CGSize(width: manager.expression.pupilOffset, height: 0))
                .frame(width: 72, height: 72)

            Text(manager.expression.label)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ViewThatFits {
                HStack {
                    activityButtons
                }

                VStack {
                    activityButtons
                }
            }

            if let errorMessage = manager.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
        }
    }

    @ViewBuilder
    private var activityButtons: some View {
        Button("Start") {
            manager.start()
        }
        .disabled(manager.isActive)

        Button("Change Expression") {
            Task {
                await manager.changeExpression()
            }
        }
        .disabled(!manager.isActive)

        Button("End", role: .destructive) {
            Task {
                await manager.end()
            }
        }
        .disabled(!manager.isActive)
    }
}

private struct TestCard<Content: View>: View {
    let title: LocalizedStringKey
    @ViewBuilder let content: Content

    init(title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 14) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            content
        }
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    ContentView()
}
