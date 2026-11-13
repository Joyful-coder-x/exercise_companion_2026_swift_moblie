import ActivityKit
import SwiftUI
import WidgetKit

enum PetExpression: String, Codable, Hashable {
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

struct PetActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var expression: PetExpression
    }

    var name: String
}

struct PetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PetActivityAttributes.self) { context in
            HStack(spacing: 16) {
                ActivityPetFace(expression: context.state.expression)
                    .frame(width: 68, height: 68)

                VStack(alignment: .leading, spacing: 4) {
                    Text(context.attributes.name)
                        .font(.headline)
                    Text(context.state.expression.label)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding()
            .activityBackgroundTint(.indigo.opacity(0.16))
            .activitySystemActionForegroundColor(.primary)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    ActivityPetFace(expression: context.state.expression)
                        .frame(width: 52, height: 52)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.expression.label)
                        .font(.caption)
                }

                DynamicIslandExpandedRegion(.bottom) {
                    Text("Expression changes are controlled from the app.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } compactLeading: {
                ActivityPetFace(expression: context.state.expression)
                    .frame(width: 24, height: 24)
            } compactTrailing: {
                Image(systemName: expressionSymbol(for: context.state.expression))
                    .foregroundStyle(.orange)
            } minimal: {
                ActivityPetFace(expression: context.state.expression)
                    .frame(width: 24, height: 24)
            }
            .keylineTint(.orange)
        }
    }

    private func expressionSymbol(for expression: PetExpression) -> String {
        switch expression {
        case .lookingLeft: "arrow.left"
        case .resting: "minus"
        case .lookingRight: "arrow.right"
        }
    }
}

private struct ActivityPetFace: View {
    let expression: PetExpression

    var body: some View {
        ZStack {
            Circle()
                .fill(.orange)

            HStack(spacing: 5) {
                eye
                eye
            }
            .offset(y: -2)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(expression.label)
    }

    private var eye: some View {
        ZStack {
            Circle()
                .fill(.white)
                .aspectRatio(0.82, contentMode: .fit)

            Circle()
                .fill(.black)
                .frame(width: 5, height: 5)
                .offset(x: expression.pupilOffset)
        }
        .frame(width: 12, height: 15)
    }
}

#Preview("Lock Screen", as: .content, using: PetActivityAttributes(name: "Wandering Ball")) {
    PetLiveActivity()
} contentStates: {
    PetActivityAttributes.ContentState(expression: .resting)
    PetActivityAttributes.ContentState(expression: .lookingLeft)
}

#Preview("Dynamic Island", as: .dynamicIsland(.expanded), using: PetActivityAttributes(name: "Wandering Ball")) {
    PetLiveActivity()
} contentStates: {
    PetActivityAttributes.ContentState(expression: .lookingRight)
}
