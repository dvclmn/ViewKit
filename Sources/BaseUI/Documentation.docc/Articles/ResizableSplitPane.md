# Resizable Split Panes

Add a persisted split boundary to any edge of one view while leaving the surrounding stack in charge of arranging every other pane.

## Overview

Apply ``SwiftUI/View/resizableSplitPane(_:edge:defaultLength:lengthRange:handleHitPadding:ignoredSafeAreaEdges:isEnabled:store:)`` to a view in an `HStack` or `VStack` with zero spacing. Select the edge that touches the adjacent pane.

For a leading sidebar, resize its trailing edge:

```swift
HStack(spacing: 0) {
  SidebarView()
    .resizableSplitPane(
      "editor.sidebarWidth",
      edge: .trailing,
      defaultLength: 260,
      lengthRange: 180...480,
    )

  EditorView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
```

For a bottom pane, resize its top edge:

```swift
VStack(spacing: 0) {
  CanvasView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)

  TimelineView()
    .resizableSplitPane(
      "editor.timelineHeight",
      edge: .top,
      defaultLength: 180,
      lengthRange: 120...360,
    )
}
```

The edge determines the explicit dimension, overlay alignment, handle geometry, resize cursor, and drag direction. Leading and trailing edges set the view's width and use a column-resize pointer; top and bottom edges set its height and use a row-resize pointer. Dragging the handle away from the modified pane's centre enlarges the pane, while dragging towards its centre shrinks it. Leading and trailing edges follow the environment's layout direction.

The existing ``SwiftUI/View/resizableSplitPane(_:defaultWidth:widthRange:handleHitPadding:ignoredSafeAreaEdges:isEnabled:store:)`` overload remains a convenience for a leading pane whose trailing edge is resizable.

The modified view owns only its explicit width or height and the handle attached to the selected boundary. The surrounding stack continues to arrange the remaining views normally, so a third or later view needs no special handling.

The modifier deliberately does not measure its parent or impose policy on the adjacent panes. Choose a `lengthRange` that preserves the space those panes need at the app's supported window sizes.

The handle's one-point divider is centred on the pane boundary. `handleHitPadding` adds an invisible interactive region on both sides of the divider without adding stack spacing.

During a drag, a transient `GestureState` translation along the selected axis is combined with the last committed length. The gesture uses global coordinates so moving the pane boundary cannot change the gesture's coordinate system, and User Defaults is written only when the drag ends.
