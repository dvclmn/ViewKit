//
//  Scrubber.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/6/2025.
//

import SwiftUI

#if canImport(AppKit)
public struct Scrubber: View {
//  @Environment(\.layoutConfig) private var layoutConfig
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutAlignment) private var layoutAlignment
  
  @State private var initialValue: CGFloat = .zero
  @State private var isHovered: Bool = false

  @State private var labelString: String = ""

  @Binding var value: Double
  let range: ClosedRange<Double>?
  let digitCount: Int
  let dragSensitivity: CGFloat
  let formatted: (Double) -> String
  let onDoubleTap: () -> Void

  /// The `6` represents a single character width, at a `callout` size
  @ScaledMetric(wrappedValue: 6, relativeTo: .callout) var digitWidth: CGFloat

  public init(
    _ value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    digitCount: Int = 3,
    dragSensitivity: CGFloat,
    formatted: @escaping (Double) -> String,
    onDoubleTap: @escaping () -> Void
  ) {
    self._value = value
    self.range = range
    self.digitCount = digitCount
    self.dragSensitivity = dragSensitivity
    self.formatted = formatted
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
//    .quickBackground(padding: 2, colour: AnyShapeStyle(.white.opacity(isHovered ? 0.06 : 0)))
//    .setStroke(style: AnyShapeStyle(Color.white.opacity(isHovered ? 0.11 : 0)))
    .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(isHovered ? 0.11 : 0)))
    .setPointerStyle(.frameResize(position: .leading, directions: .all))
    .onDoubleTap {
      onDoubleTap()
    }
    .gesture(digitDragGesture(for: layoutAxis ?? .horizontal))
    .onHover { hovered in
      isHovered = hovered
    }
    .onAppear {
      initialValue = value
    }
    .task(id: value) {
      self.labelString = formatted(value)
    }
  }
}

extension Scrubber {

  var totalWidth: CGFloat {
    /// The digits, plus room for one character for
    #warning("Needs to be properly calculated")
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
        let delta = gestureValue.translation.length(for: axis) * dragSensitivity
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
