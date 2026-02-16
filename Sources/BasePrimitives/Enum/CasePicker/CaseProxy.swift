//
//  CaseProxy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import CasePaths
import SwiftUI

@MainActor
public struct CaseProxy<Root> where Root: CasePathable {
  let selection: Binding<Root>

  /// Use with case key paths: `proxy.case(\.wave)`
  /// The case key path is automatically converted to AnyCasePath
  public func `case`<Value>(
    _ caseKeyPath: CaseKeyPath<Root, Value>
  ) -> Binding<Value>? {
    /// Convert case key path to AnyCasePath
    let casePath = AnyCasePath(caseKeyPath)
    return CaseBinding(casePath: casePath, root: selection).binding()
  }

  /// Direct AnyCasePath variant for backwards compatibility
  public func binding<Value>(
    _ casePath: AnyCasePath<Root, Value>
  ) -> Binding<Value>? {
    CaseBinding(casePath: casePath, root: selection).binding()
  }

  // MARK: - Clamped variants for BinaryFloatingPoint associated values

  /// Create a clamped binding for a floating-point associated value using a CaseKeyPath
  public func `case`<Value>(
    _ caseKeyPath: CaseKeyPath<Root, Value>,
    clamp range: ClosedRange<Value>
  ) -> Binding<Value>? where Value: BinaryFloatingPoint {
    let casePath = AnyCasePath(caseKeyPath)
    guard let base = CaseBinding(casePath: casePath, root: selection).binding() else { return nil }
    return Binding<Value>(
      get: { base.wrappedValue.clamped(to: range) },
      set: { newValue in
        base.wrappedValue = newValue.clamped(to: range)
      }
    )
  }

  /// Create a clamped binding for a floating-point associated value using AnyCasePath
  public func binding<Value>(
    _ casePath: AnyCasePath<Root, Value>,
    clamp range: ClosedRange<Value>
  ) -> Binding<Value>? where Value: BinaryFloatingPoint {
    guard let base = CaseBinding(casePath: casePath, root: selection).binding() else { return nil }
    return Binding<Value>(
      get: { base.wrappedValue.clamped(to: range) },
      set: { newValue in
        base.wrappedValue = newValue.clamped(to: range)
      }
    )
  }
}
