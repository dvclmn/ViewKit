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

/// Stateless drag tracker helper
struct CumulativeDragTracker {
  private var initialOffset: CGSize?
  let axisMode: AxisMode

  public init(
    axisMode: AxisMode
  ) {
    self.axisMode = axisMode
  }

  mutating func beginIfNeeded(latestValue: CGSize) {
    if initialOffset == nil {
      initialOffset = latestValue
    }
  }

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

  mutating func end() {
    initialOffset = nil
  }
}

/// IMPORTANT: The below actually works great. The downside was that
/// if the (e.g.) Pan value changes *outside* of the ViewModifier, then this tracker
/// doesn't get the memo, and it's state becomes stale. For instances where state is
/// only required to be managed locally by this tracker, this works great.
///
/// Tracks offset by anchoring at the beginning of a drag and accumulating from there
struct CumulativeDragInternalStateTracker {
  var currentValue: CGSize = .zero
  private var anchor: CGPoint?

  mutating func beginIfNeeded() {
    if anchor == nil {
      anchor = CGPoint(fromSize: currentValue)
    }
  }

  mutating func update(with translation: CGSize) -> CGSize {
    guard let anchor = anchor else { return currentValue }
    currentValue = translation + anchor
    return currentValue
  }

  mutating func end() {
    anchor = nil
  }
}
