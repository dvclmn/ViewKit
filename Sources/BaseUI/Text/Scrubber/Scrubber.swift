//
//  Scrubber.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/6/2025.
//

import SwiftUI

#if canImport(AppKit)
public struct TextScrubber: View {
  @Environment(\.formatValue) private var formatValue
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutAlignment) private var layoutAlignment

  @State private var initialValue: CGFloat
  @State private var isHovered: Bool = false

  @Binding var value: Double
  let range: ClosedRange<Double>?
  let digitCount: Int
  let dragSensitivity: CGFloat
  let onDoubleTap: () -> Void

  /// The `6` represents a single character width, at a `callout` size
  @ScaledMetric(wrappedValue: 6, relativeTo: .callout) var digitWidth: CGFloat

  public init(
    _ value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    digitCount: Int = 3,
    dragSensitivity: CGFloat,
    onDoubleTap: @escaping () -> Void
  ) {
    self._value = value
    self._initialValue = State(initialValue: CGFloat(value.wrappedValue))
    self.range = range
    self.digitCount = digitCount
    self.dragSensitivity = dragSensitivity
    self.onDoubleTap = onDoubleTap
  }

  public var body: some View {
    HStack(spacing: 0) {
      Text(labelString)
        .fixedSize(horizontal: true, vertical: false)
        .monospacedDigit()
        .frame(
          width: digitWidth * CGFloat(digitCount),
          height: digitWidth * 1.8,
          alignment: .trailing
        )
    }
    .frame(
      width: totalWidth,
      height: digitWidth * 1.8,
      alignment: .trailing
    )
    .quickBackground(padding: 8)
    .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(isHovered ? 0.11 : 0)))
    .setPointerStyle(.frameResize(position: .leading, directions: .all))
    .onDoubleTap { onDoubleTap() }
    .gesture(digitDragGesture(for: layoutAxis ?? .horizontal))
    .onHover { isHovered = $0 }
  }
}

extension TextScrubber {
  
  private var labelString: String { formatValue(value) }

  var totalWidth: CGFloat {
    /// The digits, plus room for one character for
    // TODO: Needs to be properly calculated
    let unitsCharacterWidth: Int = 1
    //    let unitsCharacterWidth: Int = unit.count
    let count: Int = digitCount + unitsCharacterWidth
    /// Little extra as well in case of a negative sign `-`
    let negativeSign: CGFloat = digitWidth * 0.5
    return digitWidth * CGFloat(count) + negativeSign
  }

  func digitDragGesture(for axis: Axis) -> some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged { gestureValue in
        let delta =
          gestureValue.translation.value(along: axis.toGridAxis, mapping: .default) * dragSensitivity
        //        let delta = gestureValue.translation.length(for: axis) * dragSensitivity
        let newValue = initialValue + delta
        let result: CGFloat
        if let range {
          result = newValue.clamped(to: range.toCGFloatRange)
        } else {
          result = newValue
        }
        value = result
      }
      .onEnded { _ in
        initialValue = value
      }
  }

}
#endif
