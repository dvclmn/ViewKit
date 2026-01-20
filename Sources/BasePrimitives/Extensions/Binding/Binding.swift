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



// MARK: - Binding CGRect
extension Binding where Value == CGRect {
  public var getOrigin: CGPoint {
    return self.wrappedValue.origin
  }
  public var getSize: CGSize {
    return self.wrappedValue.size
  }

  public var toBindingOrigin: Binding<CGPoint> {
    return Binding<CGPoint> {
      return self.wrappedValue.origin
    } set: { newValue in
      let currentSize: CGSize = self.wrappedValue.size
      self.wrappedValue = CGRect(origin: newValue, size: currentSize)
    }
  }

  public var toBindingSize: Binding<CGSize> {
    return Binding<CGSize> {
      return self.wrappedValue.size
    } set: { newValue in
      let currentOrigin: CGPoint = self.wrappedValue.origin
      self.wrappedValue = CGRect(origin: currentOrigin, size: newValue)
    }
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

// MARK: - Binding CGPoint
//extension Binding where Value == CGPoint {
//  public var toBinding: CGPoint {
//    return self.wrappedValue.origin
//  }
//  public var getSize: CGSize {
//    return self.wrappedValue.size
//  }
//  
//  public var toBindingOrigin: Binding<CGPoint> {
//    return Binding<CGPoint> {
//      return self.wrappedValue.origin
//    } set: { newValue in
//      let currentSize: CGSize = self.wrappedValue.size
//      self.wrappedValue = CGRect(origin: newValue, size: currentSize)
//    }
//  }
//  
//  public var toBindingSize: Binding<CGSize> {
//    return Binding<CGSize> {
//      return self.wrappedValue.size
//    } set: { newValue in
//      let currentOrigin: CGPoint = self.wrappedValue.origin
//      self.wrappedValue = CGRect(origin: currentOrigin, size: newValue)
//    }
//  }
//}

//public extension Binding {
//
//  static func convert<TInt, TFloat>(_ intBinding: Binding<TInt>) -> Binding<TFloat>
//  where TInt: BinaryInteger & Sendable,
//        TFloat: BinaryFloatingPoint, TFloat.Stride: BinaryFloatingPoint {
//
//          Binding<TFloat> (
//            get: { TFloat(intBinding.wrappedValue) },
//            set: { intBinding.wrappedValue = TInt($0) }
//          )
//        }
//
//  static func convert<TFloat, TInt>(_ floatBinding: Binding<TFloat>) -> Binding<TInt>
//  where TFloat: BinaryFloatingPoint & Sendable,
//        TFloat.Stride: BinaryFloatingPoint,
//        TInt: BinaryInteger {
//
//          Binding<TInt> (
//            get: { TInt(floatBinding.wrappedValue) },
//            set: { floatBinding.wrappedValue = TFloat($0) }
//          )
//        }
//}
