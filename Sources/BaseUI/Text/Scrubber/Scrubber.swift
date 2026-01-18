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
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.modifierKeys) private var modifierKeys
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.fractionLength) private var fractionLength
  @Environment(\.isStepperShowing) private var isStepperShowing

  //  @State private var isHovered: Bool = false

  @State private var store: ScrubberHandler
  //  @State private var initialValue: CGFloat
  @GestureState private var dragDelta: CGFloat = .zero

  let title: String
  @Binding var value: Double
  let range: ClosedRange<Double>?

  /// Have turned off step, at least for now, and focusing on the
  /// increments of 1, 10 and 100.
  //  let step: Double?
  let dragSensitivity: CGFloat
  let onDoubleTap: () -> Void

  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    //    step: Double? = nil,
    dragSensitivity: CGFloat = 0.2,
    onDoubleTap: @escaping () -> Void = {}
  ) {
    self.title = title
    self._value = value
    self._store = State(initialValue: ScrubberHandler(initialValue: value.wrappedValue))
    //    self._initialValue = State(initialValue: CGFloat(value.wrappedValue))
    self.range = range
    //    self.step = step
    self.dragSensitivity = dragSensitivity
    self.onDoubleTap = onDoubleTap
  }

  public var body: some View {
    HStack(spacing: layoutSpacing) {

      LabeledContent(title) {
        ValueEditor()

        if isStepperShowing {
          Stepper(
            title,
            value: valueClamped,
            step: stepSize,
          )
          /// Don't need extra label, this Stepper is in a broader labeled View
          .labelsHidden()
        }
      }
    }
    .sensoryFeedback(.alignment, trigger: value) {
      oldValue,
      newValue in
      /// If no step provided, no haptics will occur.
      /// Only allow haptic feedback when actively dragging
      guard isDragging else { return false }
      return HapticPreset.perStep(stepSize).shouldFire(oldValue, newValue)
    }
    .backgroundTint(isDragging ? Color.accentColor.opacity(0.1) : nil)
    .animation(Styles.animationQuickNSmooth, value: isDragging)

    .environment(\.strokeColour, AnyShapeStyle(Color.white.opacity(store.isHovered ? 0.11 : 0)))

    .onDoubleTap { onDoubleTap() }
    .gesture(digitDragGesture(for: layoutAxis ?? .horizontal))
    .onHover { store.isHovered = $0 }

    /// Handle case where `value` changes externally
    .task(id: value) {
      /// Keep store in sync
      store.value = value

      /// Maintain fresh initial state, if changed
      if dragDelta == .zero {
        updateIfChanged(&store.initialValue, to: value)
      }
    }
    .task(id: range) { store.range = range }
  }
}

extension TextScrubber {
  private var formattedString: String { formatValue(value) }

  private var valueClamped: Binding<Double> {
    $value.clampedIfNeeded(to: range)
  }
  //  private var places: NumberFormatStyleConfiguration.Precision { .fractionLength(0...2) }

  @ViewBuilder
  private func ValueEditor() -> some View {
    Text(valueClamped.wrappedValue.displayString(places: fractionLength ?? 0))
      .allowsHitTesting(isHoldingOption)
      .opacity(isHoldingOption ? 1 : 0)
      .setPointerStyle(.frameResize(position: .leading, directions: .all))
      .padding(.horizontal, Styles.sizeSmall)

      .overlay {
        if !isHoldingOption {
          IncrementTextField(title: title, value: valueClamped)
        }
      }
      .monospacedDigit()
  }

  private var isHoldingOption: Bool {
    isDebugMode || modifierKeys == .option
  }

  private var stepSize: CGFloat {
    return {
      if modifierKeys == .command {
        100
      } else if modifierKeys == .shift {
        10
      } else {
        1
      }
    }()
  }

  private var isDragging: Bool { dragDelta != .zero }

  private var sensitivity: CGFloat {
    let reducedSensitivity: CGFloat = dragSensitivity * 0.35
    let isModeChanged = modifierKeys == .option && !isDragging
    return isModeChanged ? reducedSensitivity : dragSensitivity
  }

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
      //      step: 5
    )

    TextScrubber(
      "My Title",
      value: $value,
      range: 1...20,
      //      step: 5
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
