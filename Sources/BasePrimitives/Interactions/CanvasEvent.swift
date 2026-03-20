//
//  CanvasEvent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/3/2026.
//

import Foundation

/// Typed canvas events that consumers can observe.
///
/// These represent meaningful interaction events in canvas-space,
/// produced by observing `CanvasInteractionState` changes and
/// mapping them through the coordinate space pipeline.
///
/// Currently fires on every active frame (`.changed` semantics).
/// Future versions may offer per-phase control (began/changed/ended).
public enum CanvasEvent: Sendable {

  /// A pointer tap at a location.
  case tap(Point<CanvasSpace>)

  /// A pointer drag producing a selection rectangle.
  /// Fires every frame while dragging.
  case drag(Rect<CanvasSpace>)
}
