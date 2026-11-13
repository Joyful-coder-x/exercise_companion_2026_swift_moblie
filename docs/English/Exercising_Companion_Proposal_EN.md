# Exercising Companion
## Final project candidate · Concept proposal

Status: proposed iOS student project, not a validated health intervention. Exercising Companion is a working title. Curio is the other candidate; both candidates will have small feasibility prototypes tested before Friday, November 20. On that Friday, compare results with classmates and the professor and select one for full implementation. The two projects have separate repositories and plans.

## 1. Project summary
Exercising Companion is a phone-based movement companion inspired by desktop pets. It helps people notice opportunities to move during an ordinary day and choose a short activity that fits their available time and setting. Instead of requiring a full workout, the first version focuses on one- to five-minute movement breaks.

The central question is: can a friendly companion make it easier to take a small movement break at a suitable moment?

## 2. Problem and intended audience
The starting observation is personal: people may know they should move more, yet forget to take breaks or be unsure what movement is appropriate. This is a hypothesis to test, not a research finding. Initial testers will be students and people who spend substantial time sitting.

Context matters. A classroom break may call for a quiet standing or seated movement, while home may permit more space and a larger range of motion. An empty calendar slot does not necessarily mean someone is available.

## 3. Proposed experience
1. A small companion invites the user to take a movement break.
2. The user selects a setting, available time, and relevant movement preferences.
3. The app recommends one movement from a curated database.
4. The user sees a simple demonstration, instructions, and a timer.
5. The companion responds when the user finishes, skips, or postpones.
6. The user can record why a suggestion was unsuitable, helping evaluate recommendation fit.

Suggested initial settings are school, home, and outdoors; suggested durations are one, two, and five minutes. These are prototype choices, not fixed product requirements. Reminders will be optional, with user-controlled timing and a clear way to dismiss them.

## 4. Companion and visual direction
The companion should feel encouraging and low-pressure. Simple idle, invitation, moving, and completion states can communicate its role without a large pet-care system. It should not punish missed breaks. The design will test whether the character makes reminders more welcome or distracting.

This is an in-app mobile companion. A character that floats over other iOS apps is not assumed; widgets or Live Activities would require a separate feasibility check and are outside the initial scope.

## 5. Recommendation approach
The initial recommendation system uses a small curated activity database, rather than AI-generated instructions. Candidate tags include setting, duration, seated or standing, required space, equipment, noise, jumping, intensity, and body area. Preferences should let users exclude unsuitable movements. Activity instructions should be checked against credible exercise guidance before testing.

AI-generated longer workout plans are a possible later extension. They are not required for the first usable prototype, and their quality would need separate review. The app should not claim to diagnose conditions or provide personalized medical treatment.

## 6. MVP scope
Include: a simple companion; manual context selection; a curated activity library; filtering; activity instructions and timer; optional local reminders; completion, skip, and postpone feedback; local progress history; empty and unavailable recommendation states.

Defer: automatic calendar and location inference; nearby venue search; full AI workout plans; cloud accounts; social features; advanced pet progression. The user's broader idea includes using schedules and location to suggest suitable exercise or nearby opportunities. These remain future directions, not completed capabilities.

## 7. Technical direction
Swift and SwiftUI are the proposed tools. A local JSON activity library, lightweight local persistence, and iOS local notifications should support the first prototype. The technical week will confirm the data model, minimum iOS version, animation approach, and actual device installation path. No backend is required for this initial scope.

Candidate records: Activity, ActivityTags, UserPreferences, ReminderSettings, and MovementSession. Recommendations should explain their fit, such as “2 minutes · quiet · standing · no equipment.” Begin with manual context so recommendation usefulness can be tested independently of automatic inference.

## 8. Validation and success criteria
Before testing, agree on practical criteria: can a participant find an appropriate suggestion without help, understand the movement, start and finish a break, and dismiss or adapt an unsuitable recommendation? Record observed behavior alongside short interviews. Ask whether the companion improves the experience and whether users want another reminder. A small class test cannot establish health benefits or long-term habit change.

Test activity fit, reminder timing, clarity, timer behavior, accessibility, and the skip path. Participation should be voluntary, and testers should stop any movement that causes discomfort. No health-benefit percentages or medical outcomes are claimed.

## 9. Deliverables and open decisions
Deliverables: a runnable iOS prototype, documented activity data, a short demo, test findings, and an updated README. Open decisions include the final name, character style, reminder defaults, activity sources, supported physical limitations, and whether any automatic context feature fits the remaining time.

See the [four-week plan](../plans/Four_Week_Plan.md). Both feasibility tests run in parallel before November 20; subsequent implementation is conditional on selecting this project on November 20.
