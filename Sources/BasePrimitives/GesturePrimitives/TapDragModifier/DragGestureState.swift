//
//  DragGestureState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

struct DragGestureState {

  var behaviour: DragBehavior

  /// The start location of the offset, captured at drag start
  private(set) var anchor: CGPoint?

  /// The last computed offset value
  private var lastComputedValue: CGSize?

  init(_ behaviour: DragBehavior) {
    self.behaviour = behaviour
  }
}

extension DragGestureState {
  var value: CGRect { lastComputedValue?.toCGRectZeroOrigin ?? .zero }

  /// For this, marquee wants the `Gesture.Value` start location
  /// Continuous wants the latest `Binding<CGRect>` offset value.
  mutating func begin(with currentExternalValue: CGPoint? = nil) {
    anchor = currentExternalValue
  }

  /// It's important for marquee to be able to expres `nil`
  /// This is also why the main binding is `Binding<CGRect?>`
  mutating func update(
    _ gestureValue: DragGesture.Value,
  ) -> CGRect? {

    switch behaviour {
      case .marquee:
        guard let anchor else { return nil }
        let newRect = gestureValue.toRect(from: anchor, end: .standard)
        lastComputedValue = newRect.size
        return newRect

      case .continuous:
        guard let anchor else { return value }
        let base = anchor.toCGSize
        let size = applyAxis(
          behaviour.axes,
          base: base,
          translation: gestureValue.translation
        )

        lastComputedValue = size
        return CGRect(origin: .zero, size: size)

      case .none: return nil
    }
  }

  mutating func end() {
    anchor = nil
  }

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
