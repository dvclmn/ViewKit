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
struct CumulativeDragController {
  let axes: GridAxis.Set
  let strategy: Strategy
  private(set) var anchor: CGPoint?
  private var currentValue: CGSize
  private var lastComputedValue: CGSize?
}

extension CumulativeDragController {
  mutating func begin(with currentExternalValue: CGSize? = nil) {
    switch strategy {
      case .external:
        guard let val = currentExternalValue else { return }
        anchor = CGPoint(x: val.width, y: val.height)
      case .internal:
        anchor = CGPoint(x: currentValue.width, y: currentValue.height)
    }
  }

  init(axes: GridAxis.Set, strategy: Strategy) {
    self.axes = axes
    self.strategy = strategy
    switch strategy {
      case .external: self.currentValue = .zero
      case .internal(let initial): self.currentValue = initial
    }
  }

  var value: CGSize {
    switch strategy {
      case .external: lastComputedValue ?? .zero
      case .internal: currentValue
    }
  }

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

  mutating func end() {
    anchor = nil
  }

  mutating func resetInternal(to newValue: CGSize) {
    guard case .internal = strategy else { return }
    currentValue = newValue
    if anchor != nil {
      anchor = CGPoint(fromSize: newValue)
    }
  }

  mutating func reanchor(to newBase: CGSize) {
    anchor = CGPoint(fromSize: newBase)
  }

  private func applyAxis(base: CGSize, translation: CGSize) -> CGSize {
    switch axes {
      case .horizontal:
        CGSize(width: base.width + translation.width, height: base.height)
      case .vertical:
        CGSize(width: base.width, height: base.height + translation.height)
      default:
        CGSize(width: base.width + translation.width, height: base.height + translation.height)
    }
  }
}
