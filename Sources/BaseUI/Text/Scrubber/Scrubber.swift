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

    /// This uses `bindModel`, as it needs to flow both ways
    .bindModel(
      debounce: .noDebounce,
      $store.value,
      to: Binding {
        guard let range else { return self.value }
        return self.value.clamped(to: range)
      } set: {
        guard let range else { return }
        self.value = $0.clamped(to: range)
      }
    )

    /// These are one-way only (from outside, into this View),
    /// so using `task` is fine
    .task(id: title) { store.title = title }
    .task(id: range) { store.range = range }
    .task(id: strategy) { store.strategy = strategy }
  }
}
#endif
