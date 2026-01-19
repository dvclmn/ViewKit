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

  @Environment(\.modifierKeys) private var modifierKeys
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.isDebugMode) private var isDebugMode

  @State private var store: ScrubberHandler
  

  let title: String
  @Binding var value: Double
  let range: ClosedRange<Double>?

  let strategy: ScrubStrategy
//  let dragSensitivity: CGFloat
//  let onDoubleTap: () -> Void

  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    strategy: ScrubStrategy = .continuous,
//    dragSensitivity: CGFloat = 0.2,
//    onDoubleTap: @escaping () -> Void = {}
  ) {
    self.title = title
    self._value = value
    self.strategy = strategy
    self._store = State(
      initialValue: ScrubberHandler(initialValue: value.wrappedValue)
    )
    self.range = range
//    self.dragSensitivity = dragSensitivity
//    self.onDoubleTap = onDoubleTap
  }

  public var body: some View {
    LabeledContent(store.title) {
      ScrubberCore(store: store)
    }
    /// Handle case where `value` changes externally
//    .task(id: value) {
//      /// Maintain fresh initial state, if changed
//      if dragDelta == .zero {
//        updateIfChanged(&store.initialValue, to: value)
//      }
//    }
    /// This uses `bindModel`, as it needs to flow both ways
    .bindModel($store.value, to: $value)

    /// These are one-way only (from outside, into this View),
    /// so using `task` is fine
    .task(id: title) { store.title = title }
    .task(id: range) { store.range = range }
    .task(id: strategy) { store.strategy = strategy }
  }
}

extension TextScrubber {
  private var formattedString: String { formatValue(value) }

  //  private var valueClamped: Binding<Double> {
  //    $value.clampedIfNeeded(to: range)
  //  }
  //  private var places: NumberFormatStyleConfiguration.Precision { .fractionLength(0...2) }

  //  @ViewBuilder
  //  private func ValueEditor() -> some View {
  //
  //  }

  //  private var isHoldingOption: Bool {
  //    isDebugMode || modifierKeys == .option
  //  }

  

  

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
