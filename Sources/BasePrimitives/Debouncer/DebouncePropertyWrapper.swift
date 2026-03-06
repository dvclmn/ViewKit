//
//  DebouncePropertyWrapper.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import SwiftUI

@MainActor
@propertyWrapper
public struct DebouncedState<Value: Equatable>: DynamicProperty {
  @State private var immediate: Value
  @State private var debounced: Value
  @State private var task: Task<Void, Never>?

  private let interval: Duration

  public init(
    wrappedValue: Value,
    interval: TimeInterval = 0.2,
  ) {
    self._immediate = State(initialValue: wrappedValue)
    self._debounced = State(initialValue: wrappedValue)
    self.interval = Duration.seconds(interval)
  }

  /// Updates immediately (what controls should write to).
  public var wrappedValue: Value {
    get { immediate }
    nonmutating set {
      guard newValue != immediate else { return }
      immediate = newValue
      scheduleDebounce(to: newValue)
    }
  }

  /// Debounced value (what your expensive work should read).
  public var projectedValue: Value { debounced }

  /// A Binding to the immediate value (handy for TextField/Slider).
  public var binding: Binding<Value> {
    Binding(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }

  /// Immediately commit the current value (skip delay).
  public func flush() {
    task?.cancel()
    task = nil
    debounced = immediate
  }

  /// Cancel any pending debounced update.
  public func cancelPending() {
    task?.cancel()
    task = nil
  }

  @MainActor
  private func scheduleDebounce(to newValue: Value) {
    task?.cancel()

    task = Task {
      try? await Task.sleep(for: interval)
      if Task.isCancelled { return }
      debounced = newValue
    }
  }
}
