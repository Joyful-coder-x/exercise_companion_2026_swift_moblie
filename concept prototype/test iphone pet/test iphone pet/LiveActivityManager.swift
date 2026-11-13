import ActivityKit
import Foundation
import Observation

struct PetActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var expression: PetExpression
    }

    var name: String
}

@MainActor
@Observable
final class LiveActivityManager {
    private(set) var isActive = false
    private(set) var expression = PetExpression.resting
    private(set) var errorMessage: String?

    init() {
        isActive = !Activity<PetActivityAttributes>.activities.isEmpty
        expression = Activity<PetActivityAttributes>.activities.first?.content.state.expression ?? .resting
    }

    func start() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            errorMessage = String(localized: "Live Activities are disabled on this device.")
            return
        }

        do {
            let content = ActivityContent(
                state: PetActivityAttributes.ContentState(expression: .resting),
                staleDate: nil
            )
            _ = try Activity.request(
                attributes: PetActivityAttributes(name: "Wandering Ball"),
                content: content,
                pushType: nil
            )
            expression = .resting
            isActive = true
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func changeExpression() async {
        guard let activity = Activity<PetActivityAttributes>.activities.first else {
            isActive = false
            return
        }

        let choices = PetExpression.allCases.filter { $0 != expression }
        expression = choices.randomElement() ?? .resting
        let content = ActivityContent(
            state: PetActivityAttributes.ContentState(expression: expression),
            staleDate: nil
        )
        await activity.update(content)
    }

    func end() async {
        let finalContent = ActivityContent(
            state: PetActivityAttributes.ContentState(expression: .resting),
            staleDate: nil
        )

        for activity in Activity<PetActivityAttributes>.activities {
            await activity.end(finalContent, dismissalPolicy: .immediate)
        }

        expression = .resting
        isActive = false
    }
}
