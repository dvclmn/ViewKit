//
//  DragGestureEvent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/3/2026.
//

import SwiftUI

/// Data struct carrying drag context, analogous to ``ZoomGestureEvent``.
///
/// Produced by ``PointerDragModifier`` on every gesture update. The caller
/// receives this alongside an ``InteractionPhase`` and can use it to route
/// drag events through a tool/interaction pipeline.
public struct DragGestureEvent: Sendable {

  /// The drag mode that produced this event.
  public var behaviour: DragBehavior

  /// The rect computed by the modifier's internal state machine.
  ///
  /// - **Marquee**: bounding rect from anchor to current pointer. `nil` on end.
  /// - **Continuous**: accumulated offset in `size`; `origin` is `.zero`.
  public var proposedRect: CGRect?

  /// Where the drag started (gesture's `startLocation`).
  public var startLocation: CGPoint

  /// Current pointer position (gesture's `location`).
  public var currentLocation: CGPoint

  /// Raw translation reported by the gesture.
  public var translation: CGSize

  /// `true` for the very first update in a drag sequence.
  public var isGestureStart: Bool

  public init(
    behaviour: DragBehavior,
    proposedRect: CGRect?,
    startLocation: CGPoint,
    currentLocation: CGPoint,
    translation: CGSize,
    isGestureStart: Bool
  ) {
    self.behaviour = behaviour
    self.proposedRect = proposedRect
    self.startLocation = startLocation
    self.currentLocation = currentLocation
    self.translation = translation
    self.isGestureStart = isGestureStart
  }
}

/// Callback receiving full ``DragGestureEvent`` context plus phase.
public typealias DragEventUpdate = (DragGestureEvent, InteractionPhase) -> Void

/// Simplified callback receiving just the proposed rect and phase.
public typealias DragUpdate = (CGRect?, InteractionPhase) -> Void
