//
//  Handler+CumulativeDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/8/2025.
//

import BasePrimitives
import SwiftUI

/// A unified drag offset controller supporting two strategies:
/// 1. External source-of-truth mode: stateless, relying on external current offset state.
/// 2. Internal owned state mode: stateful, owning and accumulating offset internally.
///

struct CumulativeDragController {

  /// The axis/axes along which drag offsets are accumulated.
  let axes: GridAxis.Set

  /// The chosen ownership strategy.
  let strategy: Strategy

  /// The anchor point corresponding to the offset at drag start.
  private(set) var anchor: CGPoint?

  /// The current offset value owned by this controller in internal mode.
  /// Mirrors the owned value; unused in external mode except for API consistency.
  private var currentValue: CGSize

  /// The last computed offset value in external mode.
  private var lastComputedValue: CGSize?

}

extension CumulativeDragController {

  /// Creates a new controller with the specified axis mode and strategy.
  /// - Parameters:
  ///   - axisMode: Axis constraints for offset accumulation.
  ///   - strategy: Ownership strategy.
  init(axes: GridAxis.Set, strategy: Strategy) {
    self.axes = axes
    self.strategy = strategy
    switch strategy {
      case .external: self.currentValue = .zero
      case .internal(let initial): self.currentValue = initial
    }
  }

  /// The current effective offset value.
  ///
  /// - For `.external` strategy, returns the last computed offset or `.zero` if none.
  /// - For `.internal` strategy, returns the owned offset value.
  var value: CGSize {
    switch strategy {
      case .external: lastComputedValue ?? .zero
      case .internal: currentValue
    }
  }

  /// Begins tracking by anchoring at the current offset value.
  ///
  /// - Parameter currentExternalValue: The current external offset value.
  ///   Required for `.external` strategy; ignored for `.internal`.
  mutating func begin(with currentExternalValue: CGSize? = nil) {
    switch strategy {
      case .external:
        guard let val = currentExternalValue else { return }
        anchor = CGPoint(x: val.width, y: val.height)
      case .internal:
        anchor = CGPoint(x: currentValue.width, y: currentValue.height)
    }
  }
  //  mutating func begin(with currentExternalValue: CGSize? = nil) {
  //    switch strategy {
  //      case .external:
  //        guard let currentExternalValue else {
  //          fatalError(
  //            "CumulativeDragController: begin(with:) requires currentExternalValue for external strategy")
  //        }
  //        anchor = CGPoint(fromSize: currentExternalValue)
  //
  //      case .internal:
  //        anchor = CGPoint(fromSize: currentValue)
  //    }
  //  }

  /// Updates the offset by applying the given translation delta, respecting axis constraints,
  /// and returns the updated offset.
  ///
  /// - Parameter translation: The latest drag translation delta.
  /// - Returns: The accumulated offset.
  mutating func update(translation: CGSize) -> CGSize {
    guard let anchor = anchor else { return value }

    let base = CGSize(width: anchor.x, height: anchor.y)
    let updated = applyAxis(base: base, translation: translation)

    switch strategy {
      case .external:
        lastComputedValue = updated
      case .internal:
        currentValue = updated
    }
    return updated
  }
  //  mutating func update(translation: CGSize) -> CGSize {
  //    guard let anchor = anchor else {
  //      /// If not anchored, just return current value
  //      return value
  //    }
  //
  //    let base = CGSize(width: anchor.x, height: anchor.y)
  //    let updated = applyAxis(base: base, translation: translation)
  //
  //    switch strategy {
  //      case .external:
  //        lastComputedValue = updated
  //        return updated
  //      case .internal:
  //        currentValue = updated
  //        lastComputedValue = updated
  //        return updated
  //    }
  //  }

  /// Ends tracking and clears the anchor.
  mutating func end() {
    anchor = nil
  }

  /// Resets the internal owned offset value to a new value.
  ///
  /// - Parameter newValue: The new offset value to set.
  ///
  /// Only applicable for `.internal` strategy; has no effect otherwise.
  ///
  /// If a drag is in progress (anchor exists), the anchor will be updated to match the new base,
  /// preventing offset drift during the gesture.
  mutating func resetInternal(to newValue: CGSize) {
    guard case .internal = strategy else { return }
    currentValue = newValue
    if anchor != nil {
      /// Update anchor to match newValue so translation remains consistent
      anchor = CGPoint(fromSize: newValue)
    }
  }

  /// Reanchors the drag to a new base offset mid-gesture.
  ///
  /// This is the recommended method to call if the external offset state
  /// jumps unexpectedly during a drag (e.g., due to model updates),
  /// to prevent offset jumps or drift.
  ///
  /// - Parameter newBase: The new offset base to anchor to.
  mutating func reanchor(to newBase: CGSize) {
    anchor = CGPoint(fromSize: newBase)
  }

  /// Applies axis constraints to the base offset plus translation.
  ///
  /// - Parameters:
  ///   - base: The anchor/base offset.
  ///   - translation: The drag translation delta.
  /// - Returns: The new offset respecting the axis mode.
  private func applyAxis(base: CGSize, translation: CGSize) -> CGSize {
    //    axes.computeOffset(from: base, with: translation)
    switch axes {
      case .horizontal:
        return CGSize(width: base.width + translation.width, height: base.height)
      case .vertical:
        return CGSize(width: base.width, height: base.height + translation.height)
      default:
        return CGSize(width: base.width + translation.width, height: base.height + translation.height)
    }
  }
}
