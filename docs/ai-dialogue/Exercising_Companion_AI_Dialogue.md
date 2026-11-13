# Exercising Companion — AI dialogue record

## Scope and attribution
This record covers only Exercising Companion-related discussion visible in the current chat. User quotations preserve original wording, repetition and spelling. Excerpts are identified; assistant responses are summaries. This is an account of the design conversation, not evidence that the proposed functions have been built or validated. Curio-specific naming discussion and its prototype are recorded separately.

## 1. Original idea
User, verbatim excerpt from a longer message discussing two project candidates:
> 然后另一个是有点像一个健身搭子的概念吧，就是它会在手机上，然后有点像借鉴电脑的桌宠，借鉴电脑的桌宠，然后，借鉴电脑的桌宠，它会根据生活习惯。 就根据我怎么活，来提供健身意见。就是从身体健康角度，人如果就是时不时，比如说半个小时、一个小时，去做一些简短的小的运动，会对身体健康有很大的帮助。然后我感觉现在大家很多人也知道这个事情，但是具体实施呢，一个是会忘记，还有一个是会就不知道具体做什么动作。然后我希望这个东西它有两个功能，一个是它能看，比如说我在课间，它看我的行程表，说现在是课间，或者是在我自己家里，我可以做这种比较简短的一两分钟就能做的动作。然后比如说课间，我可能在学校，它会推荐一些比较适合，就是不是太夸张的动作。如果在家，我可能，它可能推荐一个动作大一点的动作。然后如果是，比如说我现在行程表上没有事情，它可能会推荐我去，取决于我现在在哪里，可能会推荐我比如说周围有一个什么运动馆，或者说建议我去健身，或者说建议我去跑步。然后如果是健身啊，或者运动馆啊，它会给我生成一个建议的 plan。这个生成的建议的 plan 会是。 AI的，其他的应该，其他的我现在暂时是想靠数据库，就是不同的标签，然后对应不同的运动。嗯，先对我的这个第二个想法做一个反馈。

Assistant summary:
- Identified the central problem as forgetting to move and not knowing which movement fits the moment.
- Suggested a friendly mobile companion offering small, immediately actionable movement breaks.
- Recommended manual setting and time selection first, since an empty calendar slot does not reliably mean availability.
- Recommended a tagged activity database and deferring venue search and full AI workout plans.
- Proposed a complete test flow: invitation, context selection, recommendation, demonstration/timer, and finish/skip/postpone feedback.
- Suggested observing whether people actually do the movement, why they skip, and whether the companion makes reminders welcome or annoying.
- Treated health outcomes and user demand as unvalidated, and recommended checking activity instructions against reliable sources.

## 2. Comparison and project choice
User, verbatim excerpt from the same message:
> 我有两个 project 方案。我会在下周上课以前把这两个方案分别做实一个 prototype，然后在下周课上找同学和老师测试并确定具体做哪个。

Assistant summary: supported testing both directions before selecting one. Exercising Companion focuses on an individual's everyday behavior, so it should be tested through actual willingness to take a movement break rather than only asking whether the idea sounds appealing.

## 3. Proposal and delivery schedule
User, verbatim excerpt:
> 行，这样，基于就是。exercise companion 基于这个第二个想法，也是生成一个像第一个想法那样的 proposal。然后分别给这两个 project一个四周的计划。就是从现在到十二月二十号左右，我要把它做出来，以周为单位。我还要留一到两周来做这个测试和细调。就是，我现在想法是下周把技术落定，具体怎么做，结构，框架，然后调研，然后下下周做出来，就是一个可以使用的，基本上可以使用的 prototype。然后去做细节调试，一两周。然后现在你一个是要做这个 proposal，写这个 proposal，然后在 readme 这个 repository。 现在第一步先生成这个这个 Exercising Companion 的 proposal，中英文。

Assistant summary: drafted English and Chinese concept proposals covering the problem, audience, interaction, companion design, tagged recommendations, MVP boundaries, SwiftUI technical direction, testing and open decisions. Proposed local data and notifications for a manageable first version, without promising automatic context inference or AI plans.

## 4. AI dialogue documentation
User, verbatim excerpt from the same request:
> 然后把目前为止我和你沟通的有关他们的对话加入进去，尤其是我的，就是我输入了哪些信息，原话，把我的原话加进去。然后把你的回应给一个大概的总结。

Assistant summary: created this project-specific record, preserving the user's source wording and labeling assistant contributions as summaries. No conversations outside the visible thread were invented.

## 5. English plans and Friday checkpoints
User, verbatim:
> 确认一下你这个计划，应该是用英文的，然后checkpoint是设在每周五以前，因为我课程是周五的。

Assistant summary: changed both work plans to English only, with checkpoints ready before Friday class and a Thursday-evening completion target. Core checkpoints are November 20, November 27, December 4 and December 11. Final presentation readiness is before December 18, with remaining buffer through approximately December 20.

## Clarification: separate projects and initial parallel tests

User, verbatim:
> [https://github.com/Joyful-coder-x/exercise_companion_2026_swift_moblie.git](https://github.com/Joyful-coder-x/exercise_companion_2026_swift_moblie.git) 这个 exercise companion 应该在这里头，不在那个。就是这是两个分开的 project，然后要有自己的计划。就是这两个会并行。准确地说是，我下周会……我下周五前会测试，会写两个小测试，来测试它们两个的可能性。然后确定以后，在下周五会把它再减成一个，然后去把它落实。

Assistant summary: separated the repositories and plans. Both small feasibility tests run in parallel before Friday, November 20, 2026. On that Friday, compare findings and select one project; only the selected project proceeds to full implementation. The other is paused. Earlier plans describing the sequence less precisely are superseded by this clarification.

## 6. Research request: a companion visible across other apps

User, verbatim:
> 针对 exercising companion 做一个 research。我想像捉虫一样让这个小，咱现在暂时比如说是一个小圆球加俩眼睛，是这个形象，这个因为形象还没有定。我想让它能够出现在手机上的任何地方，最好是像 YouTube 的那个小花框一样，它可以在不同，就是它不受我打开其他 app 影响。看一下它有没有可能实施，然后大概就是需要哪些技术，给我一到两个方案，然后给我一些 article description。

Assistant summary:
- Researched Apple documentation for cross-app display, Picture in Picture (PiP), Live Activities, background execution and review requirements.
- Distinguished a character inside a system-managed video window from a transparent character moving freely over other apps.
- Proposed two iOS approaches: PiP using AVKit/AVFoundation, or Live Activities using ActivityKit/WidgetKit for Dynamic Island and Lock Screen presentations.
- Described AVPlayer/AVPlayerLayer for prerecorded animation and AVSampleBufferDisplayLayer for generated video frames. PiP does not directly host an arbitrary interactive SwiftUI screen.
- Explained that the documented PiP APIs do not provide a supported transparent, borderless pet overlay. Window positioning and controls are system-managed; continuous display cannot be guaranteed.
- Recommended a user-started, finite movement session rather than using media background execution solely to keep a decorative pet alive. App Store review approval was not promised.
- Explained that Live Activities suit ongoing session status, not an unrestricted continuous animation loop. No device test or implemented prototype was claimed.

## 7. Follow-up: can it crawl freely over the phone screen?

User, verbatim:
> 像虫一个在，就是在手机屏幕上移动这个有任何解决方案吗，还是现在的确没有。

Assistant summary:
- Clarified that on a non-jailbroken iPhone, ordinary public APIs do not offer a general-purpose transparent overlay that freely crawls over other apps. App windows belong to the app's own scenes.
- Clarified the PiP distinction: a character can move inside the video window; that does not let the app autonomously move the system PiP window around the whole screen.
- Noted that Android offers a closer implementation path through TYPE_APPLICATION_OVERLAY and user-granted SYSTEM_ALERT_WINDOW authorization, while still having system, app and background-execution restrictions.
- Suggested retaining iOS if app-contained animation or system containers are acceptable, and considering Android if unrestricted-looking cross-app movement is the central interaction. No platform change was decided.

## 8. Minimal technical test app

User, verbatim:
> So for now I want to write a sort of test-run app that basically have, like, a little ball with two eyes that is moving randomly, so it's, like, looking around randomly. So it's kind of a random app, like it has some movement to it. And then I want to, through the app, have this little guy show up in picture-in-picture, with preferably transparent background, and have it also show up in 灵动岛和锁屏. Give me the link to technology I need to achieve this, and rough description on how to do it. Make it as simple and as clean as possible so I can focus on the technique itself.

Assistant summary:
- Proposed one minimal SwiftUI app with three isolated technical tests, without a backend, AI, exercise database or third-party libraries.
- In-app test: draw a circular body, eyes and pupils with SwiftUI shapes; periodically choose bounded random body destinations and pupil offsets, and animate changes. Stop the animation task when the view disappears. Canvas and TimelineView are optional later tools.
- PiP test: first play a short prerecorded animation through AVPlayer and AVPictureInPictureController to verify cross-app presentation. Clearly distinguish prerecorded motion from genuine random movement. If needed later, render live random motion into CMSampleBuffer frames for AVSampleBufferDisplayLayer, with substantially more implementation work.
- Include PiP support checks, a user-operated start/stop control, media audio-session configuration and the Audio, AirPlay, and Picture in Picture background capability. Use an opaque background for the initial test; transparent SwiftUI backgrounds do not establish transparent cross-app PiP.
- Live Activity test: add a Widget Extension with Live Activity support, enable NSSupportsLiveActivities, define a small expression state, and provide ActivityConfiguration layouts for Lock Screen and Dynamic Island compact, minimal and expanded presentations. These are presentations of one Live Activity, not two separate systems.
- Start with app buttons for Start, Change Expression and End. Use a static character with occasional state changes; Live Activities do not support an unrestricted background animation loop, and ordinary SwiftUI timers do not keep running indefinitely after suspension. Documented update animations have a maximum duration of two seconds.
- Suggested iOS 17+ as a convenient prototype target and a physical Dynamic Island-equipped iPhone for verification. The proposed test interface contains only the character, PiP controls and Live Activity controls. No code or device verification was completed in this exchange.

### Official technical references discussed

- [SwiftUI graphics: Add rich graphics to your SwiftUI app](https://developer.apple.com/videos/play/wwdc2021/10021/) — drawing, Canvas and time-driven animation.
- [Adopting Picture in Picture in a custom player](https://developer.apple.com/documentation/avkit/adopting-picture-in-picture-in-a-custom-player) — support checks, player integration, lifecycle and restoring the app interface.
- [Sample-buffer PiP content source](https://developer.apple.com/documentation/avkit/avpictureinpicturecontroller/contentsource-swift.class/init(samplebufferdisplaylayer:playbackdelegate:)) — the generated-video-frame approach.
- [Displaying live data with Live Activities](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities) — setup and lifecycle.
- [Creating custom views for Live Activities](https://developer.apple.com/documentation/activitykit/creating-custom-views-for-live-activities) — Lock Screen and Dynamic Island layouts.
- [Animating data updates in widgets and Live Activities](https://developer.apple.com/documentation/widgetkit/animating-data-updates-in-widgets-and-live-activities) — supported update animations and limits.
- [Adding interactivity to widgets and Live Activities](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities) — App Intents-based actions.
- [Scheduling a notification locally from your app](https://developer.apple.com/documentation/usernotifications/scheduling-a-notification-locally-from-your-app) — system-scheduled reminders.
- [Multitask with Picture in Picture on iPhone](https://support.apple.com/guide/iphone/multitask-with-picture-in-picture-iphcc3587b5d/ios) — user-controlled window movement and resizing.
- [App Review Guidelines: software requirements](https://developer.apple.com/app-store/review/guidelines/#software-requirements) — intended uses of background services.
- [UIWindowScene](https://developer.apple.com/documentation/uikit/uiwindowscene) — app-scoped windows.
- [Android application overlays](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#TYPE_APPLICATION_OVERLAY) — the alternative platform's overlay API.

These links record the sources used in the discussion. Proposed behaviors still require implementation and physical-device testing; this dialogue is not evidence of completed functionality.
