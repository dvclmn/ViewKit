//
//  Cumulative+Stateless.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

///
/// A stateless drag offset tracker designed to work with an external source-of-truth value.
///
/// This tracker anchors at the initial drag offset (captured externally) and accumulates
/// translation deltas based on the configured axis mode (horizontal, vertical, or both).
///
/// Usage:
/// - Begin tracking by calling `beginIfNeeded(latestValue:)` passing the current external offset.
/// - Call `computeOffset(translation:)` during drag updates to get the new offset based on the accumulated drag.
/// - Call `end()` to reset the internal anchor.
///
/// Lifecycle & Behavior:
/// - This struct does not own the offset state; it assumes an external state (e.g., SwiftUI state or model)
///   is the source-of-truth and provides the initial offset when a drag begins.
/// - It only tracks the offset relative to the anchor established at drag start.
/// - Because it relies solely on the external initial offset, if the external state updates outside of this tracker's
///   lifecycle (e.g., mid-drag), the internal anchor may become stale and cause jumpy or incorrect offset calculations.
///
/// Pros:
/// - Simple, stateless approach.
/// - Clear separation of responsibilities: external manages state, tracker manages accumulation logic.
/// - Supports axis-specific offset accumulation.
///
/// Cons:
/// - Susceptible to staleness if external source-of-truth changes unexpectedly during a drag.
/// - Requires careful synchronization with external state.
///
/// When to Use:
/// - When drag offset state is maintained externally and only need a helper to accumulate deltas.
/// - When your drag updates are fully controlled by an external SwiftUI state or model.
///
struct CumulativeDragTracker {
  /// The initial offset at the start of the drag gesture, serving as the anchor point.
  private var initialOffset: CGSize?

  /// The axis mode limiting drag accumulation: horizontal, vertical, or both axes.
  let axes: GridAxis.Set

  /// Creates a new tracker configured with the given axis mode.
  /// - Parameter axes: The axis along which drag offsets should be accumulated.
  public init(
    axes: GridAxis.Set
  ) {
    self.axes = axes
  }

  /// Begins tracking if not already started by capturing the external drag offset as the anchor.
  /// - Parameter latestValue: The current external offset value at drag start.
  mutating func beginIfNeeded(latestValue: CGSize) {
    if initialOffset == nil {
      initialOffset = latestValue
    }
  }

  /// Computes the current offset by accumulating the translation on top of the anchor,
  /// respecting the configured axis mode.
  /// - Parameter translation: The latest drag translation delta.
  /// - Returns: The accumulated offset if tracking has begun, or nil if not anchored.
  func computeOffset(translation: CGSize) -> CGSize? {
    guard let initialOffset else { return nil }
    return axes.computeOffset(from: initialOffset, with: translation)
    
  }

  /// Ends tracking and clears the anchor.
  mutating func end() {
    initialOffset = nil
  }
}

extension GridAxis.Set {
  func computeOffset(from base: CGSize, with translation: CGSize) -> CGSize {
    switch self {
      case .horizontal:
        CGSize(
          width: base.width + translation.width,
          height: base.height
        )

      case .vertical:
        CGSize(
          width: base.width,
          height: base.height + translation.height
        )
      default:  // Aka `all`
        base + translation
    }
  }
}
