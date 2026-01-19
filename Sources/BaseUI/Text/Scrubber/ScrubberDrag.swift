//
//  ScrubberDrag.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools
import SwiftUI

struct ScrubDragGesture: Gesture {
  @Environment(\.modifierKeys) private var modifierKeys
  @State private var initialValue: Double = .zero
  @GestureState private var dragDelta: CGFloat = .zero

  /// May consider making these configurable in future
  let dragSensitivity: CGFloat = 0.2
  let axis: Axis = .horizontal

  @Bindable var store: ScrubberHandler

  var body: some Gesture {

    /// Stable baseline
    /// When drag begins → baseline is fixed
    /// While dragging → delta changes continuously
    /// When drag ends / cancels → delta resets automatically to .zero
    DragGesture(minimumDistance: 0)
      .updating($dragDelta) { gestureValue, dragDelta, _ in
        let translation =
          gestureValue.translation.value(
            along: axis.toGridAxis,
            mapping: .default
          )
        dragDelta = translation * sensitivity
      }
      .onChanged { _ in
        store.value = clampedValue(from: initialValue, delta: dragDelta)
      }
      .onEnded { _ in
        initialValue = CGFloat(store.value)
      }
  }

}

extension ScrubDragGesture {

  private var isDragging: Bool { dragDelta != .zero }
  
  func clampedValue(from baseline: CGFloat, delta: CGFloat) -> CGFloat {
    let proposed = baseline + delta
    return store.range.map {
      proposed.clamped(to: $0.toCGFloatRange)
    } ?? proposed
  }

  private var sensitivity: CGFloat {
    let reducedSensitivity: CGFloat = dragSensitivity * 0.35
    let isModeChanged = modifierKeys == .option && !isDragging
    return isModeChanged ? reducedSensitivity : dragSensitivity
  }

}
