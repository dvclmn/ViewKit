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

@MainActor
extension CasePickerHandler {
  /// A meta-only binding that switches the underlying enum while preserving payloads via cache.
  func metaBinding(_ root: Binding<Enum>) -> Binding<Enum.Meta> {
    Binding<Enum.Meta>(
      get: {
        // If something else mutated `root`, keep handler state in sync.
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
