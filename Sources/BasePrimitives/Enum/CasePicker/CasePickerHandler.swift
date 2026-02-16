//
//  AnotherAttemptPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import SwiftUI

/// Owns the “case switching policy” for `MetaEnum` values.
///
/// SwiftUI’s selection controls (Picker/List/SegmentedControl) are great at switching
/// between *cases*, but they do not preserve associated values when you bounce between
/// cases over time.
///
/// `CasePathHandler` provides that missing behaviour:
/// - Tracks the currently selected `Meta` case
/// - Caches the last full enum value used for each `Meta`
/// - When switching meta, restores the cached value (or constructs a default via
///   `init?(fromMeta:)`), so payloads are preserved across case switches.
///
/// This handler is UI-agnostic: it can drive Pickers, Lists, sidebars, menus, commands, etc.
@Observable
public final class CasePathHandler<Enum: MetaEnum> {
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
  
  /// Switch to a new case, preserving the old value in cache.
  /// Returns whether the underlying enum actually changed.
  @discardableResult
  public func switchTo(_ newMeta: Enum.Meta, binding: Binding<Enum>) -> Bool {
    let currentMeta = binding.wrappedValue.meta
    if selectedMeta != currentMeta { selectedMeta = currentMeta }
    
    guard currentMeta != newMeta else { return true }
    
    // Cache current value under its *actual* meta.
    cache[currentMeta] = binding.wrappedValue
    
    if let restored = cache[newMeta] {
      binding.wrappedValue = restored
      selectedMeta = newMeta
      return true
    }
    
    if let fresh = Enum(fromMeta: newMeta) {
      binding.wrappedValue = fresh
      cache[newMeta] = fresh
      selectedMeta = newMeta
      return true
    }
    
    // Could not switch. Keep selectedMeta aligned with reality.
    selectedMeta = binding.wrappedValue.meta
    return false
  }
//  func switchTo(_ newMeta: Enum.Meta, binding: Binding<Enum>) {
//    guard selectedMeta != newMeta else { return }
//
//    /// Cache current value
//    cache[selectedMeta] = binding.wrappedValue
//
//    if let restored = cache[newMeta] {
//      binding.wrappedValue = restored
//    } else if let fresh = Enum(fromMeta: newMeta) {
//      binding.wrappedValue = fresh
//      cache[newMeta] = fresh
//    }
//
//    selectedMeta = newMeta
//  }
}

@MainActor
extension CasePathHandler {
  /// A meta-only binding that switches the underlying enum while preserving payloads via cache.
  public func metaBinding(_ root: Binding<Enum>) -> Binding<Enum.Meta> {
    Binding<Enum.Meta>(
      get: {
        /// If something else mutated `root`, keep handler state in sync.
        let meta = root.wrappedValue.meta
        if self.selectedMeta != meta { self.selectedMeta = meta }
        return meta
      },
      set: { newMeta in
        self.switchTo(newMeta, binding: root)
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
