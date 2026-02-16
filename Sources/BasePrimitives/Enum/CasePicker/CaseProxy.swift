//
//  CaseProxy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import CasePaths
import SwiftUI

@MainActor
public struct CaseProxy<Root: CasePathable> {
  let selection: Binding<Root>

  /// Use with case key paths: `proxy.case(\.wave)`
  /// The case key path is automatically converted to AnyCasePath
  public func `case`<Value>(_ caseKeyPath: CaseKeyPath<Root, Value>) -> Binding<Value>? {
    binding(AnyCasePath(caseKeyPath))
  }

  /// Direct AnyCasePath variant for backwards compatibility
  public func binding<Value>(_ casePath: AnyCasePath<Root, Value>) -> Binding<Value>? {
    CaseBinding(casePath: casePath, root: selection).binding()
  }

  /// Create a clamped binding for a floating-point associated value using a CaseKeyPath
  public func `case`<Value>(
    _ caseKeyPath: CaseKeyPath<Root, Value>,
    clamp range: ClosedRange<Value>
  ) -> Binding<Value>? where Value: BinaryFloatingPoint {
    binding(AnyCasePath(caseKeyPath), clamp: range)
  }

  /// Create a clamped binding for a floating-point associated value using AnyCasePath
  public func binding<Value>(
    _ casePath: AnyCasePath<Root, Value>,
    clamp range: ClosedRange<Value>
  ) -> Binding<Value>? where Value: BinaryFloatingPoint {
    guard let base = binding(casePath) else { return nil }
    return Binding(
      get: { base.wrappedValue.clamped(to: range) },
      set: { base.wrappedValue = $0.clamped(to: range) }
    )
  }
}
