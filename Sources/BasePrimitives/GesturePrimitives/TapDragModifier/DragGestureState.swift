//
//  DragGestureState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

/// Internal state machine for ``UnifiedDragModifier``.
///
/// Handles both ``DragBehavior/marquee`` and ``DragBehavior/continuous(_:)`` modes
/// through a shared `begin` / `update` / `end` lifecycle, driven by `DragGesture`
/// callbacks in the parent modifier.
///
/// The output is always `CGRect?` so a single `Binding<CGRect?>` covers both modes:
/// - **Marquee**: the rect from anchor to current pointer position.
/// - **Continuous**: offset stored in `size`; `origin` is always `.zero`.
struct DragGestureState {

  var behaviour: DragBehavior

  /// The start location captured once at the beginning of each drag gesture.
  private(set) var anchor: CGPoint?

  /// The most recently computed result, retained so `value` stays stable between drags.
  private var lastComputedOffset: CGSize?

  init(_ behaviour: DragBehavior) {
    self.behaviour = behaviour
  }
}

extension DragGestureState {

  /// The current result as a rect. Origin is always `.zero`; continuous offset lives in `size`.
  var value: CGRect { lastComputedOffset?.toCGRectZeroOrigin ?? .zero }

  /// Captures the anchor point at the start of a drag.
  ///
  /// - Parameter currentExternalValue:
  ///   - **Marquee**: pass `gestureValue.startLocation` so the rect grows from the tap point.
  ///   - **Continuous**: pass the current binding offset as a `CGPoint` so the next drag
  ///     compounds from the correct baseline.
  mutating func begin(with currentExternalValue: CGPoint? = nil) {
    anchor = currentExternalValue
  }

  /// Processes a live drag gesture value and returns the updated result.
  ///
  /// - Returns:
  ///   - `.marquee`: The bounding `CGRect` from anchor to current pointer. `nil` until anchored.
  ///   - `.continuous`: The accumulated offset rect (origin `.zero`). Falls back to `value` if not yet anchored.
  ///   - `.none`: Always `nil`.
  mutating func update(
    _ gestureValue: DragGesture.Value
  ) -> CGRect? {

    switch behaviour {
      case .marquee:
        guard let anchor else { return nil }
        let newRect = gestureValue.toRect(from: anchor, end: .standard)
        lastComputedOffset = newRect.size
        return newRect

      case .continuous:
        guard let anchor else { return value }
        let base = anchor.toCGSize
        let size = applyAxis(
          behaviour.axes,
          base: base,
          translation: gestureValue.translation
        )
        lastComputedOffset = size
        return CGRect(origin: .zero, size: size)

      case .none: return nil
    }
  }

  /// Clears the anchor. Call from `DragGesture.onEnded`.
  mutating func end() {
    anchor = nil
  }

  /// Applies axis constraints, zeroing out movement on the locked axis.
  private func applyAxis(
    _ axes: GridAxis.Set,
    base: CGSize,
    translation: CGSize
  ) -> CGSize {
    switch axes {
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
      default:
        CGSize(
          width: base.width + translation.width,
          height: base.height + translation.height
        )
    }
  }
}
