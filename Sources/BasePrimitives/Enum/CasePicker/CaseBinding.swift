//
//  CaseBinding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import CasePaths
import SwiftUI


/// Provides bindable access to associated values of a specific enum case
@MainActor
public struct CaseBinding<Root, Value> {
  let casePath: AnyCasePath<Root, Value>
  let root: Binding<Root>
  
  public func binding() -> Binding<Value>? {
    guard casePath.extract(from: root.wrappedValue) != nil else {
      return nil
    }
    
    return Binding<Value>(
      get: { casePath.extract(from: root.wrappedValue)! },
      set: { newValue in
        root.wrappedValue = casePath.embed(newValue)
      }
    )
  }
}


//public struct CaseBinding<Root, Value> {
////  let casePath: CaseKeyPath<Root, Value>
//  let casePath: AnyCasePath<Root, Value>
//  let root: Binding<Root>
//
//  /// Create a binding to the associated value, only if the enum is currently in this case
//  public func binding() -> Binding<Value>? {
//    guard casePath.extract(from: root.wrappedValue) != nil else {
//      return nil
//    }
//
//    return Binding<Value>(
//      get: { casePath.extract(from: root.wrappedValue)! },
//      set: { newValue in
//        root.wrappedValue = casePath.embed(newValue)
//      }
//    )
//  }
//
//  /// Force-unwrapped binding (use when you know the case matches)
//  public func binding() -> Binding<Value> where Value == Void {
//    binding() ?? Binding.constant(())
//  }
//}
