//
//  AnotherAttemptPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import SwiftUI

@Observable
public final class CasePickerHandler<Enum: MetaEnum> {
  var selectedMeta: Enum.Meta
  @ObservationIgnored private var cache: [Enum.Meta: Enum]

  public init(initialValue: Enum) {
    self.selectedMeta = initialValue.meta
    self.cache = [initialValue.meta: initialValue]
  }

  /// Get or restore a value for the given meta case
  func value(for meta: Enum.Meta, binding: Binding<Enum>) -> Enum {
    if binding.wrappedValue.meta == meta {
      return binding.wrappedValue
    }
    return cache[meta] ?? Enum(fromMeta: meta) ?? binding.wrappedValue
  }

  /// Switch to a new case, preserving the old value in cache
  func switchTo(_ newMeta: Enum.Meta, binding: Binding<Enum>) {
    guard selectedMeta != newMeta else { return }

    /// Cache current value
    cache[selectedMeta] = binding.wrappedValue

    if let restored = cache[newMeta] {
      binding.wrappedValue = restored
    } else if let fresh = Enum(fromMeta: newMeta) {
      binding.wrappedValue = fresh
      cache[newMeta] = fresh
    }

    selectedMeta = newMeta
  }
}

// MARK: - Case Binding Helper

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

// MARK: - Utility: clamp helper for floating-point
private extension BinaryFloatingPoint {
  func clamped(to range: ClosedRange<Self>) -> Self {
    return min(max(self, range.lowerBound), range.upperBound)
  }
}

// MARK: - Case Proxy
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

// MARK: - View Extensions for Conditional Content
//extension View {
//  /// Show this view only when the enum matches the given case
//  public func showIf<Root, Value>(
//    _ binding: Binding<Root>,
//    matches casePath: AnyCasePath<Root, Value>
//  ) -> some View {
//    self.opacity(casePath.extract(from: binding.wrappedValue) != nil ? 1 : 0)
//      .disabled(casePath.extract(from: binding.wrappedValue) == nil)
//  }
//}

