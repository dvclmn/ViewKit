//
//  Binding.swift
//  Collection
//
//  Created by Dave Coleman on 1/11/2024.
//

import SwiftUI

//import Sharing

//extension Binding {
//  public func toSharedBinding<T>() -> Binding<T> {
//
//  }
//}

extension Binding where Value == Int {
  /// Convert `Int` Binding to `Double` Binding
  public var toBindingDouble: Binding<Double> {
    Binding<Double>(
      get: { Double(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }
  /// Convert `Int` Binding to `Double` Binding
  public var toBindingCGFloat: Binding<CGFloat> {
    Binding<CGFloat>(
      get: { CGFloat(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }

  /// Convert `Int` Binding to `Double` Binding
  public func toBindingBinaryFloatingPoint<T: BinaryFloatingPoint & Sendable>() -> Binding<T> {
    Binding<T>(
      get: { T(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }
}

extension Binding {
  //  public func toBindingArray() -> Binding<[Value]> where Value == Set<Self.Element> {
  //    Binding<[Value]>(
  //      get: { Array(wrappedValue) },
  //      set: { wrappedValue = Array($0) }
  //    )
  //  }

//  public func toBindingArray() -> Binding<Value> where Value: MutableCollection, Value: Comparable {
//    Binding<Value>(
//      get: {
//        let thing = self.wrappedValue
//        thing.sorted(by: <#T##(Value.Element, Value.Element) throws -> Bool#>)
////        Array(arrayLiteral: wrappedValue).sorted()
//      },
//      set: { wrappedValue = Set($0) }
//    )
//  }
  
//  public func toBindingArray() -> Binding<Value> where Value: Hashable, Value == [Element], Element: Comparable {
//    Binding<Value>(
//      get: { Array(wrappedValue).sorted() },
//      set: { wrappedValue = Set($0) }
//    )
//  }
}

extension Binding where Value: BinaryFloatingPoint & Sendable {
  //  public func clampedIfNeeded(to range: ClosedRange<Value>?) -> Binding<Value> {
  //    guard let range else { return self }
  //    return Binding<Value>(
  //      get: { wrappedValue.clamped(to: range) },
  //      set: { wrappedValue = $0.clamped(to: range) }
  //    )
  //  }

  public var toBindingCGFloat: Binding<CGFloat> {
    Binding<CGFloat>(
      get: { CGFloat(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }
  public var toBindingDouble: Binding<Double> {
    Binding<Double>(
      get: { Double(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }

}
extension Binding where Value == ClosedRange<Int> {
  public func toBindingBinaryFloatingPoint<T: BinaryFloatingPoint & Sendable>() -> Binding<ClosedRange<T>> {
    Binding<ClosedRange<T>>(
      get: { wrappedValue.toBinaryFloatingPointRange() },
      set: { wrappedValue = $0.toIntRange }
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
  /// Returns a Boolean binding that toggles the Bool for the given Key in the Dictionary
  @MainActor
  public func bindingBool<T>(key: T) -> Binding<Bool>
  where Value == [T: Bool], T: Hashable {
    Binding<Bool> {
      wrappedValue[key] ?? false
    } set: {
      wrappedValue[key] = $0
    }
  }
  //  func contains(_ element: Value) -> Binding<Bool> {
  //    Binding<Bool>(
  //      get: { wrappedValue.contains(element) },
  //      set: { isIncluded in
  //        if isIncluded {
  //          wrappedValue.insert(element)
  //        } else {
  //          wrappedValue.remove(element)
  //        }
  //      }
  //    )
  //  }
}

//extension Binding where Value == CGFloat {
//  /// Convert `CGFloat` Binding to `Double` Binding
//  public var toBindingDouble: Binding<Double> {
//    Binding<Double>(
//      get: { Double(wrappedValue) },
//      set: { wrappedValue = Value($0) }
//    )
//  }
//}
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
//extension Binding where Value == Double {
//  /// Convert `Double` Binding to `CGFloat` Binding
//  public var toBindingFloat: Binding<CGFloat> {
//    Binding<CGFloat>(
//      get: { CGFloat(wrappedValue) },
//      set: { wrappedValue = Value($0) }
//    )
//  }
//}

//extension Binding {
//  //extension Binding where Self: Sendable, Value: Sendable {
//  @MainActor
//  public func createBinding(_ keyPath: ReferenceWritableKeyPath<Self, Value>) -> Binding<Value> {
//    return Binding(
//      get: { self[keyPath: keyPath] },
//      set: { self[keyPath: keyPath] = $0 }
//    )
//  }
//}
