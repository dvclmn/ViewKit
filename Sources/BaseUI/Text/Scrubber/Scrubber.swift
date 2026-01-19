//
//  Scrubber.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/6/2025.
//

import CoreTools
import LayoutKit
import SwiftUI

#if canImport(AppKit)
public struct TextScrubber: View, ValueFormattable {
  @Environment(\.isDebugMode) private var isDebugMode

  @State private var store: ScrubberHandler

  let title: String
  @Binding var value: Double
  let range: ClosedRange<Double>?
  let strategy: ScrubStrategy

  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>? = nil,
    strategy: ScrubStrategy = .continuous,
  ) {
    self.title = title
    self._value = value
    self.strategy = strategy
    self._store = State(
      initialValue: ScrubberHandler(initialValue: value.wrappedValue)
    )
    self.range = range
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
    .bindModel($store.value, to: $value.clampedIfNeeded(to: range))

    /// These are one-way only (from outside, into this View),
    /// so using `task` is fine
    .task(id: title) { store.title = title }
    .task(id: range) { store.range = range }
    .task(id: strategy) { store.strategy = strategy }
  }
}
#endif
