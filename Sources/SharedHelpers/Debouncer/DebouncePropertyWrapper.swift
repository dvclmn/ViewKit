//
//  DebouncePropertyWrapper.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import SwiftUI

@propertyWrapper
public struct DebouncedState<Value: Equatable>: DynamicProperty {
  @State private var immediate: Value
  @State private var debounced: Value
  @State private var task: Task<Void, Never>?
  
  private let delay: Duration
  private let applyOnMainActor: Bool
  
  public init(
    wrappedValue: Value,
    delay: Duration = .milliseconds(250),
    applyOnMainActor: Bool = true
  ) {
    self._immediate = State(initialValue: wrappedValue)
    self._debounced = State(initialValue: wrappedValue)
    self.delay = delay
    self.applyOnMainActor = applyOnMainActor
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
  
  private func scheduleDebounce(to newValue: Value) {
    task?.cancel()
    
    task = Task { [delay, applyOnMainActor] in
      try? await Task.sleep(for: delay)
      if Task.isCancelled { return }
      
      if applyOnMainActor {
        await MainActor.run { debounced = newValue }
      } else {
        debounced = newValue
      }
    }
  }
}
