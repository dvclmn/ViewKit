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
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.modifierKeys) private var modifierKeys
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.isStepperShowing) private var isStepperShowing

  @State private var isHovered: Bool = false

  @State private var initialValue: CGFloat
  @GestureState private var dragDelta: CGFloat = .zero

  @State private var numberFormatter: NumberFormatter = {
    var nf = NumberFormatter()
    nf.numberStyle = .decimal
    return nf
  }()

  let title: String
  @Binding var value: Double
  let range: ClosedRange<Double>?
  let step: Double?
  let dragSensitivity: CGFloat
  let onDoubleTap: () -> Void

  /// The `6` represents a single character width, at a `callout` size
  @ScaledMetric(wrappedValue: 6, relativeTo: .callout) var digitWidth: CGFloat

  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    step: Double? = nil,
    dragSensitivity: CGFloat = 0.2,
    onDoubleTap: @escaping () -> Void = {}
  ) {
    self.title = title
    self._value = value
    self._initialValue = State(initialValue: CGFloat(value.wrappedValue))
    self.range = range
    self.step = step
    self.dragSensitivity = dragSensitivity
    self.onDoubleTap = onDoubleTap
  }

  public var body: some View {
    HStack(spacing: layoutSpacing) {

      LabeledContent(title) {
        ValueEditor()
          .monospacedDigit()

        if let step, isStepperShowing {
          Stepper(
            title,
            value: $value.clampedIfNeeded(to: range),
            step: step
          ) { editingDidChange in

          }
          /// Don't need extra label, this Stepper is in a broader labeled View
          .labelsHidden()
        }
      }
      
      

      //      TextColumns {
      //        Text(labelString)
      //          .foregroundStyle(.blue)
      //          .monospacedDigit()
      //
      //      }
      //      .overlay {
      //        TextField(title, value: $value, formatter: numberFormatter)
      //      }
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
      /// If no step provided, no haptics will occur.
      /// Only allow haptic feedback when actively dragging
      guard let step, isDragging else { return false }
      return HapticPreset.perStep(step).shouldFire(oldValue, newValue)
    }
    //    .frame(
    //      width: totalWidth,
    //      height: digitWidth * 1.8,
    //      alignment: .trailing
    //    )
    //    .quickBackground(padding: 8)
    .backgroundTint(isDragging ? Color.accentColor.opacity(0.1) : nil)
    .animation(Styles.animationQuickNSmooth, value: isDragging)

    .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(isHovered ? 0.11 : 0)))

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

  private var places: Int { 2 }
  //  private var places: NumberFormatStyleConfiguration.Precision { .fractionLength(0...2) }

  @ViewBuilder
  private func ValueEditor() -> some View {
    Text(value.displayString(places: places))
      .allowsHitTesting(isHoldingOption)
      .opacity(isHoldingOption ? 1 : 0)
      .setPointerStyle(.frameResize(position: .leading, directions: .all))
      .padding(.horizontal, Styles.sizeSmall)

      .overlay {
        if !isHoldingOption {
          TextField(title, value: $value, format: .number.precision(.fractionLength(places)))
            .labelsHidden()
            //      TextField(title, value: $value, formatter: numberFormatter)
            .onKeyPress(
              keys: [.upArrow, .downArrow],
              phases: .all
            ) { press in
              if press.key == .upArrow {
                return updateValue(.up)

              } else if press.key == .downArrow {
                return updateValue(.down)

              } else {
                return .ignored
              }

            }
        }
      }

  }

  private var isHoldingOption: Bool {
    isDebugMode || modifierKeys == .option
  }

  private func updateValue(_ direction: Direction) -> KeyPress.Result {
    let stepSize: CGFloat = {
      if modifierKeys == .command {
        100
      } else if modifierKeys == .shift {
        10
      } else {
        1
      }
    }()
    switch direction {
      case .up:
        value += stepSize
      case .down:
        value -= stepSize
      case .left, .right:
        print("\(direction) not supported for this action.")
        return .ignored
    }
    return .handled
  }

  private var isDragging: Bool { dragDelta != .zero }

  private var sensitivity: CGFloat {
    let reducedSensitivity: CGFloat = dragSensitivity * 0.35
    let isModeChanged = modifierKeys == .option && !isDragging
    return isModeChanged ? reducedSensitivity : dragSensitivity
  }
  private var formattedString: String { formatValue(value) }

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

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var value: Double = 5.0
  VStack(spacing: Styles.sizeMedium) {
    TextScrubber(
      "My Title",
      value: $value,
      range: 1...20,
      step: 5
    )

    TextScrubber(
      "My Title",
      value: $value,
      range: 1...20,
      step: 5
    )
    .environment(\.isDebugMode, true)
    
    TextColumns(6, alignment: .center) {
      Text("123456")
        .monospaced()
    }
    .environment(\.isDebugMode, true)
  }
  .font(.title)
  .padding(80)
  .background(.black.secondary)
}
#endif
