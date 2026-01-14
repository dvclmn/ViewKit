//
//  Cumulative+Stateful.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

///
/// A stateful drag offset tracker that owns and accumulates offset state internally,
/// anchoring at the start of a drag and accumulating translation deltas.
///
/// This tracker manages its own current offset state (`currentValue`) and an internal anchor
/// point corresponding to the drag start. It resists external state changes during a gesture,
/// and is designed for use cases where the state is locally owned and not externally driven.
///
/// Usage:
/// - Call `beginIfNeeded()` at drag start to establish the anchor from the current value.
/// - Call `update(with:)` with translation deltas to update and get the new offset.
/// - Call `end()` to reset the anchor at gesture end.
///
/// Lifecycle & Behavior:
/// - This struct owns the offset state internally, so it will not reflect external changes
///   to offset during a drag gesture.
/// - To synchronize with external models, the model should update this tracker’s `currentValue`
///   outside of active drags, or the tracker should be re-initialized.
///
/// Pros:
/// - Self-contained state ownership prevents staleness due to external updates during a drag.
/// - Simple API for local drag state tracking.
///
/// Cons:
/// - Does not automatically sync with external models during a drag gesture.
/// - Requires explicit synchronization for external changes.
///
/// When to Use:
/// - When you want the drag offset state managed internally and isolated from external changes.
/// - When drag gestures are local and do not depend on external offset state.
///
struct CumulativeDragInternalStateTracker {
  /// The current accumulated offset value owned by this tracker.
  var currentValue: CGSize = .zero
  
  /// The anchor point corresponding to the offset at drag start.
  private var anchor: CGPoint?
  
  /// Begins tracking by anchoring at the current offset value if not already anchored.
  mutating func beginIfNeeded() {
    if anchor == nil {
      anchor = CGPoint(fromSize: currentValue)
    }
  }
  
  /// Updates the current offset by applying the given translation delta relative to the anchor.
  /// - Parameter translation: The current drag translation delta.
  /// - Returns: The updated accumulated offset.
  mutating func update(with translation: CGSize) -> CGSize {
    guard let anchor = anchor else { return currentValue }
    currentValue = translation + anchor
    return currentValue
  }
  
  /// Ends tracking and clears the anchor.
  mutating func end() {
    anchor = nil
  }
}
