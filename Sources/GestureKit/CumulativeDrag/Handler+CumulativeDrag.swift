//
//  Handler+CumulativeDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/8/2025.
//

import BasePrimitives
import SwiftUI

enum AxisMode {
  case both
  case horizontal
  case vertical
}

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
  let axisMode: AxisMode

  /// Creates a new tracker configured with the given axis mode.
  /// - Parameter axisMode: The axis along which drag offsets should be accumulated.
  public init(
    axisMode: AxisMode
  ) {
    self.axisMode = axisMode
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

    switch axisMode {
      case .both:
        return CGSize(
          width: initialOffset.width + translation.width,
          height: initialOffset.height + translation.height)
      case .horizontal:
        return CGSize(
          width: initialOffset.width + translation.width,
          height: initialOffset.height)
      case .vertical:
        return CGSize(
          width: initialOffset.width,
          height: initialOffset.height + translation.height)
    }
  }

  /// Ends tracking and clears the anchor.
  mutating func end() {
    initialOffset = nil
  }
}

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
///
/// A unified drag offset controller supporting two strategies:
/// 1. External source-of-truth mode: stateless, relying on external current offset state.
/// 2. Internal owned state mode: stateful, owning and accumulating offset internally.
///
/// This controller manages the lifecycle of drag offset tracking, with axis constraints,
/// anchoring at drag start, and accumulation of translation deltas.
///
///
/// ## Strategy Enum
/// - `external`: The controller accepts the current external offset at drag start and computes
///   new offsets based on translation deltas. No internal state is owned.
/// - `internal(initial: CGSize)`: The controller owns the offset state starting from the given initial value,
///   updating it internally during drag.
///
///
/// ## Usage
///
/// Use the `begin(with:)` method at the start of a drag gesture to anchor the offset.
/// - For `.external` strategy, pass the current external offset as `currentExternalValue`.
/// - For `.internal` strategy, `currentExternalValue` is ignored.
///
/// Use the `update(translation:)` method to apply new translation deltas and get the updated offset.
///
/// Call `end()` to clear the anchor at the end of a drag.
///
/// If the external state jumps unexpectedly mid-drag in `.external` mode,
/// call `reanchor(to:)` to reset the anchor and avoid jumps.
///
/// In `.internal` mode, use `resetInternal(to:)` to replace the owned offset value,
/// optionally syncing the anchor if a drag is in progress.
///
///
/// ## Axis Behavior
///
/// The offset accumulation respects the configured `AxisMode`:
/// - `.both`: accumulate both width and height.
/// - `.horizontal`: accumulate only width, keep height fixed.
/// - `.vertical`: accumulate only height, keep width fixed.
///
///
/// ## Notes
///
/// - This controller consolidates the behavior of the previous separate trackers into one,
///   enabling flexible ownership and better resilience to external state changes.
/// - When using `.external` mode, you must provide the current offset explicitly at drag start.
/// - Be mindful to call `reanchor(to:)` if the external model changes mid-gesture to prevent drift.
///
///
/// ## Example Integration with SwiftUI Gesture:
///
/// ```swift
/// @State private var offset: CGSize = .zero
/// @GestureState private var dragTranslation: CGSize = .zero
///
/// var body: some View {
///   let dragController = CumulativeDragController(axisMode: .both, strategy: .external)
///   let dragGesture = DragGesture()
///     .onChanged { value in
///       dragController.begin(with: offset)
///       offset = dragController.update(translation: value.translation)
///     }
///     .onEnded { _ in
///       dragController.end()
///     }
///
///   Rectangle()
///     .offset(offset)
///     .gesture(dragGesture)
/// ```
///
struct CumulativeDragController {
  /// Strategy determining whether the controller owns its state or relies on an external source.
  enum Strategy {
    /// External source-of-truth mode.
    /// The controller accepts the current offset at drag start.
    case external
    /// Internal owned state mode.
    /// The controller owns the offset starting from the given initial value.
    case `internal`(initial: CGSize)
  }

  /// The axis along which drag offsets are accumulated.
  let axisMode: AxisMode

  /// The chosen ownership strategy.
  let strategy: Strategy

  /// The anchor point corresponding to the offset at drag start.
  private var anchor: CGPoint?

  /// The current offset value owned by this controller in internal mode.
  /// Mirrors the owned value; unused in external mode except for API consistency.
  private var currentValue: CGSize

  /// The last computed offset value in external mode.
  private var lastComputedValue: CGSize?

  /// Creates a new controller with the specified axis mode and strategy.
  /// - Parameters:
  ///   - axisMode: Axis constraints for offset accumulation.
  ///   - strategy: Ownership strategy.
  init(axisMode: AxisMode, strategy: Strategy) {
    self.axisMode = axisMode
    self.strategy = strategy
    switch strategy {
      case .external:
        self.currentValue = .zero
      case let .internal(initial):
        self.currentValue = initial
    }
  }

  /// The current effective offset value.
  ///
  /// - For `.external` strategy, returns the last computed offset or `.zero` if none.
  /// - For `.internal` strategy, returns the owned offset value.
  var value: CGSize {
    switch strategy {
      case .external:
        return lastComputedValue ?? .zero
      case .internal:
        return currentValue
    }
  }

  /// Begins tracking by anchoring at the current offset value.
  ///
  /// - Parameter currentExternalValue: The current external offset value.
  ///   Required for `.external` strategy; ignored for `.internal`.
  mutating func begin(with currentExternalValue: CGSize? = nil) {
    switch strategy {
      case .external:
        guard let externalValue = currentExternalValue else {
          fatalError("CumulativeDragController: begin(with:) requires currentExternalValue for external strategy")
        }
        anchor = CGPoint(fromSize: externalValue)
      case .internal:
        anchor = CGPoint(fromSize: currentValue)
    }
  }

  /// Updates the offset by applying the given translation delta, respecting axis constraints,
  /// and returns the updated offset.
  ///
  /// - Parameter translation: The latest drag translation delta.
  /// - Returns: The accumulated offset.
  mutating func update(translation: CGSize) -> CGSize {
    guard let anchor = anchor else {
      // If not anchored, just return current value
      return value
    }

    let base = CGSize(width: anchor.x, height: anchor.y)
    let updated = applyAxis(base: base, translation: translation)

    switch strategy {
      case .external:
        lastComputedValue = updated
        return updated
      case .internal:
        currentValue = updated
        lastComputedValue = updated
        return updated
    }
  }

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
      // Update anchor to match newValue so translation remains consistent
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
    switch axisMode {
      case .both:
        return CGSize(width: base.width + translation.width, height: base.height + translation.height)
      case .horizontal:
        return CGSize(width: base.width + translation.width, height: base.height)
      case .vertical:
        return CGSize(width: base.width, height: base.height + translation.height)
    }
  }
}

