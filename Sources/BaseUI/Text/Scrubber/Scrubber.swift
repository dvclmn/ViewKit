//
//  Scrubber.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/6/2025.
//

import CoreTools
import SwiftUI

#if canImport(AppKit)
public struct TextScrubber: View, ValueFormattable {
  @Environment(\.formatValue) private var formatValue
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.modifierKeys) private var modifierKeys
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns

  @State private var isHovered: Bool = false

  @State private var initialValue: CGFloat
  @GestureState private var dragDelta: CGFloat = .zero

  @Binding var value: Double
  let range: ClosedRange<Double>?
  let step: Double?
  //  let digitCount: Int
  let dragSensitivity: CGFloat
  let onDoubleTap: () -> Void

  /// The `6` represents a single character width, at a `callout` size
  @ScaledMetric(wrappedValue: 6, relativeTo: .callout) var digitWidth: CGFloat

  public init(
    _ value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    step: Double? = nil,
    //    digitCount: Int = 3,
    dragSensitivity: CGFloat,
    onDoubleTap: @escaping () -> Void = {}
  ) {
    self._value = value
    self._initialValue = State(initialValue: CGFloat(value.wrappedValue))
    self.range = range
    self.step = step
    //    self.digitCount = digitCount
    self.dragSensitivity = dragSensitivity
    self.onDoubleTap = onDoubleTap
  }

  public var body: some View {
    HStack(spacing: 0) {
      TextColumns {
        Text(labelString)
          .monospacedDigit()
      }
      //      Text(labelString)
      //        .fixedSize(horizontal: true, vertical: false)
      //        .monospacedDigit()
      //        .frame(
      //          width: digitWidth * CGFloat(digitCount),
      //          height: digitWidth * 1.8,
      //          alignment: .trailing
      //        )
    }
    .sensoryFeedback(.alignment, trigger: value) {
      oldValue,
      newValue in
      /// If no step provided, no haptics will occur
      guard let step else { return false }
      return HapticPreset.perStep(step).shouldFire(oldValue, newValue)
    }
    //    .frame(
    //      width: totalWidth,
    //      height: digitWidth * 1.8,
    //      alignment: .trailing
    //    )
    .quickBackground(padding: 8)
    .backgroundTint(isDragging ? Color.accentColor.opacity(0.1) : nil)
    .animation(Styles.animationQuickNSmooth, value: isDragging)

    .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(isHovered ? 0.11 : 0)))
    .setPointerStyle(.frameResize(position: .leading, directions: .all))
    .onDoubleTap { onDoubleTap() }
    .gesture(digitDragGesture(for: layoutAxis ?? .horizontal))
    .onHover { isHovered = $0 }

    /// Handle case where `value` changes externally
    .task(id: value) {
      if dragDelta == .zero {
        initialValue = value
      }
    }

  }
}

extension TextScrubber {

  private var isDragging: Bool { dragDelta != .zero }

  private var sensitivity: CGFloat {
    let reducedSensitivity: CGFloat = dragSensitivity * 0.35
    let isModeChanged = modifierKeys == .option && !isDragging
    return isModeChanged ? reducedSensitivity : dragSensitivity
  }
  private var labelString: String { formatValue(value) }

  /// Stable baseline
  /// When drag begins → baseline is fixed
  /// While dragging → delta changes continuously
  /// When drag ends / cancels → delta resets automatically to .zero
  func digitDragGesture(for axis: Axis) -> some Gesture {
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
        value = clampedValue(from: initialValue, delta: dragDelta)
      }
      .onEnded { _ in
        initialValue = CGFloat(value)
      }
  }

  func clampedValue(from baseline: CGFloat, delta: CGFloat) -> CGFloat {
    let proposed = baseline + delta
    return range.map {
      proposed.clamped(to: $0.toCGFloatRange)
    } ?? proposed
  }

}
#endif
