//
//  CanvasIntent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

import Foundation

/// The output of a tool's `resolve()` method.
///
/// These are **canvas-level state mutations** only — things that
/// `CanvasInteractionState` knows how to execute. Domain-level
/// outputs (e.g. "place a shape", "commit a stroke") go through
/// `ToolAction` instead.
///
/// Note: Global gestures (pan via swipe, zoom via pinch, hover)
/// are handled centrally in `handleInput()` and never produce
/// a `CanvasIntent` from a tool.
public enum CanvasIntent: Sendable {

  /// Replace the entire transform state (pan, zoom, rotation).
  case mutateTransform(TransformState)

  /// Update the pointer drag rectangle (e.g. marquee selection,
  /// or a tool-driven drag region).
  case updatePointerDrag(Rect<ScreenSpace>?)

  /// Update the pointer tap location.
  case updatePointerTap(Point<ScreenSpace>?)

  /// No canvas state change needed.
  case none
}
