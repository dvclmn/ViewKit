//
//  Binding.swift
//  Collection
//
//  Created by Dave Coleman on 1/11/2024.
//

import SwiftUI

extension Binding where Value == CGFloat {
  /// Convert `CGFloat` Binding to `Double` Binding
  public var toBindingDouble: Binding<Double> {
    Binding<Double>(
      get: { Double(wrappedValue) },
      set: { wrappedValue = CGFloat($0) }
    )
  }
}
//extension Binding {
//  @MainActor
//  public func keyPathBinding(
//    keyPath: ReferenceWritableKeyPath<Value, Double>
//  ) -> Binding<Double> {
//    Binding {
//      self.wrappedValue[keyPath: keyPath]
//    } set: {
//      self[keyPath: keyPath] = $0
//    }
//  }
//}
extension Binding where Value == Double {
  /// Convert `Double` Binding to `CGFloat` Binding
  public var toBindingFloat: Binding<CGFloat> {
    Binding<CGFloat>(
      get: { CGFloat(wrappedValue) },
      set: { wrappedValue = Double($0) }
    )
  }
}

extension Binding where Value == Int {
  /// Convert `Int` Binding to `Double` Binding
  public var toBindingDouble: Binding<Double> {
    Binding<Double>(
      get: { Double(wrappedValue) },
      set: { wrappedValue = Int($0) }
    )
  }
}

extension Binding where Value: BinaryFloatingPoint & Sendable {
  public func clampedIfNeeded(to range: ClosedRange<Value>?) -> Binding<Value> {
    guard let range else { return self }
    return Binding<Value>(
      get: { wrappedValue.clamped(to: range) },
      set: { wrappedValue = $0.clamped(to: range) }
    )
  }
}

extension Binding where Value == Bool {
  public var reversed: Binding<Bool> {
    return .init(
      get: { !self.wrappedValue },
      set: { self.wrappedValue = !$0 }
    )
  }
}

// MARK: - OptionSet
extension Binding where Value: OptionSet & Sendable, Value.Element == Value {
  /// Returns a Boolean binding that toggles the presence of a single option in the set.
  func contains(_ element: Value) -> Binding<Bool> {
    Binding<Bool>(
      get: { wrappedValue.contains(element) },
      set: { isIncluded in
        if isIncluded {
          wrappedValue.insert(element)
        } else {
          wrappedValue.remove(element)
        }
      }
    )
  }
}

extension Binding {
  //extension Binding where Self: Sendable, Value: Sendable {
  @MainActor
  public func createBinding(_ keyPath: ReferenceWritableKeyPath<Self, Value>) -> Binding<Value> {
    return Binding(
      get: { self[keyPath: keyPath] },
      set: { self[keyPath: keyPath] = $0 }
    )
  }
}
