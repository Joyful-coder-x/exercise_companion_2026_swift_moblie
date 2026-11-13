# Exercising Companion

An iOS movement companion inspired by desktop pets. It recommends short movement breaks that fit the user's setting and available time. Swift and SwiftUI are the intended implementation tools.

## Proposal

- [English — concept proposal](docs/English/Exercising_Companion_Proposal_EN.md)
- [Chinese / 中文 — 概念提案](docs/Chinese/Exercising_Companion_Proposal_ZH.md)

## Planned features

This table distinguishes the implemented technical tester from proposed movement features. The technical test isolates the character and iOS display APIs. Movement-companion MVP work proceeds only if this project is selected after the comparative tests.

| Feature | What it does | Scope |
|---|---|---|
| Simple companion | Display a temporary ball character with two eyes. Final character design is undecided. | Immediate technical test |
| Random movement and gaze | Move within the app's bounds and independently change the direction of its pupils. | Immediate technical test |
| Picture in Picture | Render live frames from the shared random motion model through CMSampleBuffer and AVSampleBufferDisplayLayer. The user has confirmed real-time PiP changes. | Implemented tester; real-time changes user-confirmed; cross-app intrusiveness unresolved |
| Dynamic Island and Lock Screen | Start, change and end one Live Activity with layouts for both surfaces. Begin with a static character and occasional expression updates. | Implemented layouts; Dynamic Island not yet working/verified; Lock Screen verification pending |
| Display controls | Provide explicit PiP and Live Activity controls so each behavior can be tested independently. | Immediate technical test |
| Context and time selection | Let users choose school, home or outdoors and a short available duration. | Movement MVP |
| Tagged activity library | Store reviewed movements with tags such as duration, setting, space, equipment and seated/standing posture. | Movement MVP |
| Suitable movement recommendation | Match a movement to selected context and preferences, and explain why it fits; show an empty state if none fits. | Movement MVP |
| Instructions and timer | Show a simple demonstration or instructions and time a short movement break. | Movement MVP |
| Completion and skip feedback | Finish, skip or postpone, with a simple companion response and an optional reason for unsuitable suggestions. | Movement MVP |
| Optional reminders | Schedule user-controlled local reminders; allow dismissal and disabling. | Movement MVP |
| Local history and preferences | Keep movement sessions and settings on the device. | Movement MVP |
| Automatic calendar/location context | Infer possible opportunities rather than asking for manual context. | Future extension; feasibility and permissions unresolved |
| Nearby venues and AI workout plans | Suggest exercise opportunities and generate longer plans. | Future extension; outside the initial MVP |

**iOS display limits:** a transparent, borderless character crawling freely over other apps is not supported through ordinary public iOS APIs. PiP transparency is not an assumed capability. Live Activities are system-managed, time-limited presentations, not unrestricted background animation surfaces. The technical test will document observed behavior rather than promise continuous cross-app animation.

## Plan and feasibility test

[Exercising Companion's four-week plan](docs/plans/Four_Week_Plan.md) is written in English, with all checkpoints before Friday class.

Before **Friday, November 20, 2026**, build and test a small companion → context → movement → feedback prototype in parallel with a separate Curio feasibility prototype. On November 20, compare findings with classmates and the professor and choose one project. Full implementation continues only for the selected project; the other is paused. If Exercising Companion is selected, a usable MVP is due before November 27, followed by two weeks of testing and refinement, with completion around December 20.

The initial prototype uses manual context selection and a curated, tagged movement library. Automatic calendar/location inference, venue discovery and AI-generated workout plans remain future directions.

## AI dialogue

[Exercising Companion dialogue record](docs/ai-dialogue/Exercising_Companion_AI_Dialogue.md) preserves original user wording and summarizes assistant feedback.

## Current status

The [iOS technical tester](concept%20prototype/test%20iphone%20pet) is now in this repository. It includes an in-app character, sample-buffer PiP rendering and Live Activity code. It is a technical prototype, not the complete movement-companion app.

| Area | Current finding | Next step |
|---|---|---|
| Real-time PiP | The user has confirmed that PiP content can change in real time. Source inspection shows a shared PetMotionModel feeding generated CMSampleBuffer frames, rather than a prerecorded video loop. | Continue testing background duration and interruptions; do not assume indefinite background execution. |
| Dynamic Island | Not yet working/verified in the user's test. A Live Activity extension and layouts exist, but code presence does not establish successful system display. | Check signing, compatible hardware, Live Activity settings and start/update behavior on a device. |
| Lock Screen | Live Activity layout exists; successful device presentation has not been separately confirmed. | Verify separately from Dynamic Island. |
| Cross-app experience | The user finds the PiP video window distracting and intrusive while using other apps. This is an unresolved usability problem even though real-time rendering works. | Test shorter, user-started sessions, less motion and system-supported placement/size options; compare with less intrusive system surfaces if Live Activities work. No fix has been selected or implemented. |

The latest findings supersede earlier documentation describing PiP as a future real-time experiment or stating that no app code is present. Companion design and movement recommendations remain in development.

Curio has its own [repository, proposal and plan](https://github.com/Joyful-coder-x/Curio_2026_swift_moblie).
