# Popups

Present brief, non-modal feedback with an explicit and predictable lifetime.

## Overview

A popup communicates a discrete event while the user remains in their current context. It is suitable for confirmations such as “Saved”, noncritical failures, and a small number of directly related actions. It is not a replacement for SwiftUI's modal `Alert`, which is appropriate when critical information requires an immediate decision.

Apply ``SwiftUI/View/popup(debugPopup:alignment:isCompact:)`` once at the scene or document root. Descendant views read ``SwiftUI/EnvironmentValues/popup`` and call ``Popup/showPopup(_:)``:

```swift
struct ExportButton: View {
  @Environment(\.popup) private var popup

  var body: some View {
    Button("Export") {
      popup?.showPopup(.make("Exported"))
    }
  }
}
```

Popups use latest-message-wins replacement. Presenting a new message cancels the previous message's dismissal task, replaces its content, and starts the new message's lifetime. An identity check prevents a superseded task from dismissing newer content.

### Choose a dismissal policy

Use ``PopupDismissBehaviour/automatic(_:showsIndicator:)`` for short informational feedback that needs no response. The default interval is four seconds. Keep the title and detail concise enough to read comfortably within the chosen interval.

Use ``PopupDismissBehaviour/manual`` for errors, loading state, longer text, and messages that contain an action. ``PopupMessage/make(_:loading:dismissal:actions:)`` and ``PopupMessage/make(_:icon:message:loading:dismissal:actions:)`` select automatic dismissal for a plain informational message and manual dismissal when loading or actions are present. Passing `dismissal` explicitly always overrides that default.

```swift
popup?.showPopup(
  .make(
    "Could not import SVG",
    icon: .symbol("exclamationmark.triangle"),
    message: error.localizedDescription,
    dismissal: .manual
  )
)
```

Every popup has a visible dismiss button. A ``PopupAction`` dismisses the popup after running by default; pass `dismissesPopup: false` only when the popup must remain relevant after the action.

### Keep continuous state at its owner

Do not present a popup for state that is only meaningful while a condition remains true. Drag-target cues, selection adornments, connection indicators, and progress tied to an existing view should be derived from that state and removed when the state ends. Their owner controls their lifetime; no timer or global popup handler is involved.

For drag and drop, show the cue while the destination is targeted and remove it for exiting, ended, and completed phases. A failed drop can then present a separate manual popup because the failure is a discrete event.

### Accessibility and motion

Presenting a popup posts an accessibility announcement without moving focus. The popup's title and detail are combined for the announcement. Popup insertion and removal use a small opacity-and-scale transition, and the transition is disabled when Reduce Motion is enabled.
