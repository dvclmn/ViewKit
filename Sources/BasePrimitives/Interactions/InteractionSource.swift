//
//  InteractionSource.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/3/2026.
//

import SwiftUI

/// The raw input source from a SwiftUI gesture modifier.
///
/// Each case maps 1:1 to a concrete gesture modifier in `InteractionModifiers`:
/// - `.swipeGesture` ↔ `.swipeGesture(isEnabled:_:)`
/// - `.pinchGesture` ↔ `.pinchGesture(initial:isEnabled:didUpdateEvent:)`
/// - `.continuousHover` ↔ `.onContinuousHover(coordinateSpace:perform:)`
/// - `.pointerTapGesture` ↔ `.onTapGesture(count:coordinateSpace:perform:)`
/// - `.pointerDragGesture` ↔ `.pointerDragGesture(rect:coordinateSpace:...)`
///
/// Under two-tier resolution:
/// - Swipe, pinch, and hover are handled globally by `CanvasInteractionState`
/// - Pointer tap and drag are forwarded to the active `CanvasTool.resolve()`

public enum InteractionSource: Sendable {
  case swipeGesture(
    delta: Size<ScreenSpace>,
    location: Point<ScreenSpace>
  )
  case pinchGesture(ZoomGestureEvent)
  // case rotation (not yet implemented)
  case continuousHover(Point<ScreenSpace>)
  case pointerTapGesture(
    PointerButton = .primary,
    location: Point<ScreenSpace>
  )
  case pointerDragGesture(
    from: Point<ScreenSpace>,
    current: Point<ScreenSpace>
  )
}

public enum PointerButton: Sendable {
  case primary
  case secondary
  case middle
}
