//
//  AnotherAttemptPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import BasePrimitives
import MacroHelpers
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
  @ObservationIgnored private let fallback: CaseFallbackStrategy<Enum>

  public init(
    initialValue: Enum,
    fallback: CaseFallbackStrategy<Enum> = .keepCurrent
  ) {
    self.selectedMeta = initialValue.meta
    self.cache = [initialValue.meta: initialValue]
    self.fallback = fallback
  }
}

extension CasePathHandler {

  /// Get or restore a value for the given meta case
  func value(for meta: Enum.Meta, binding: Binding<Enum>) -> Enum {
    if binding.wrappedValue.meta == meta {
      return binding.wrappedValue
    }
    return cache[meta] ?? Enum(fromMeta: meta) ?? binding.wrappedValue
  }

  /// Switch to a new case, preserving the old value in cache.
  /// Returns whether the underlying enum actually changed.
  ///
  /// Example usage:
  /// ```
  /// @State private var handler = CasePickerHandler<DemoTab>(
  ///   initialValue: .graphics(.actionLines),
  ///   fallback: .fallbackValue { meta in
  ///     switch meta {
  ///       case .graphics: return .graphics(.actionLines)
  ///       default: return DemoTab(fromMeta: meta) // or nil if you prefer
  ///     }
  ///   }
  /// )
  /// ```
  @discardableResult
  public func switchTo(_ newMeta: Enum.Meta, binding: Binding<Enum>) -> Bool {

    /// Sync in case the bound value changed externally
    let currentMeta = binding.wrappedValue.meta
    if selectedMeta != currentMeta { selectedMeta = currentMeta }

    guard currentMeta != newMeta else { return true }

    /// Cache current value under its *actual* meta.
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

    // Apply fallback policy
    switch fallback {
      case .keepCurrent:
        selectedMeta = binding.wrappedValue.meta
        return false

      case .fallbackValue(let make):
        guard let value = make(newMeta) else {
          selectedMeta = binding.wrappedValue.meta
          return false
        }
        binding.wrappedValue = value
        cache[newMeta] = value
        selectedMeta = newMeta
        return true

      case .assertAndKeepCurrent(let message):
        assertionFailure(message())
        selectedMeta = binding.wrappedValue.meta
        return false
    }
  }
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
