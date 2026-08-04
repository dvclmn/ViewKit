# Resizable Split Panes

Add a persisted horizontal split boundary to one view while leaving the surrounding stack in charge of arranging every other pane.

## Overview

Apply ``SwiftUI/View/resizableSplitPane(_:defaultWidth:widthRange:handleHitPadding:store:)`` to the first view in an `HStack` with zero spacing:

```swift
HStack(spacing: 0) {
  SidebarView()
    .resizableSplitPane(
      "editor.sidebarWidth",
      defaultWidth: 260,
      widthRange: 180...480,
    )

  EditorView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
```

The modified view owns only its explicit width and the handle attached to its trailing boundary. The `HStack` continues to arrange the remaining views normally, so a third or later view needs no special handling.

The modifier deliberately does not measure its parent or impose policy on the trailing panes. Choose a `widthRange` that preserves the space those panes need at the app's supported window sizes.

The handle's one-point divider is centred on the pane boundary. `handleHitPadding` adds an invisible interactive region on both its leading and trailing sides without adding stack spacing.

During a drag, a transient `GestureState` translation is combined with the last committed width. The gesture uses global coordinates so moving the pane boundary cannot change the gesture's coordinate system, and User Defaults is written only when the drag ends.
