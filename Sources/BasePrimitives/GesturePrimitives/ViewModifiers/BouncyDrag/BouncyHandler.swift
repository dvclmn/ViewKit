//
//  DragHandler.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/3/2025.
//

import SwiftUI

struct BouncyHandler {
  var tension: CGFloat
  var isEnabled: Bool
  var inputMethod: DragMethod = .idle
  var dragOffset: CGSize = .zero
  var scale = BouncyScale()
  var containerSize: CGSize = .zero

  init(
    tension: CGFloat,
    isEnabled: Bool
  ) {
    self.tension = tension
    self.isEnabled = isEnabled
  }
}

extension BouncyHandler {
  mutating func reset() {
    dragOffset = .zero
    inputMethod = .idle
  }

  func isInputMethodEnabled(_ input: DragMethod) -> Bool {
    guard isEnabled,
      inputMethod == .idle
    else { return false }
    return true
  }

  func handleScale() -> CGFloat {
    let distance = sqrt(pow(dragOffset.width, 2) + pow(dragOffset.height, 2))

    if distance <= scale.deadZone {
      return 1.0
    }

    let adjustedDistance = (distance - scale.deadZone) / 1000
    let normalised = min(max(adjustedDistance, 0), 1)
    let curved = scale.curve.value(at: normalised, min: 0, max: 1)
    return 1.0 + (curved * scale.maxEffectThreshold)
  }
}
