//
//  CasePathHandler.swift
//  ViewKit
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import EnumMacroSupport
import SwiftUI

/// Owns the case-switching policy for an associated-value enum.
///
/// SwiftUI selection controls are effective at switching between hashable values,
/// but an enum's complete value also contains the payload of its active case.
/// Reconstructing that value from a case identity discards previously edited
/// payloads.
///
/// `CasePathHandler` provides that missing behaviour:
/// - Tracks the currently selected `Meta` case.
/// - Caches the last complete enum value used for each `Meta` case.
/// - When switching meta, restores the cached value (or constructs a default via
///   `init?(fromMeta:)`).
///
/// The handler is UI-agnostic. Use ``metaBinding(_:)`` with `Picker`, `List`, or
/// another selection API directly, or pass the handler to ``CaseMetaPicker``.
/// Keep one handler at the nearest stable owner when several views can change the
/// same enum. Its cache is intentionally in-memory and is not persistence.
@Observable
public final class CasePathHandler<Enum: MetaEnumRepresentable> {
  var selectedMeta: Enum.Meta
  @ObservationIgnored private var cache: [Enum.Meta: Enum]
  @ObservationIgnored private let fallback: CaseFallbackStrategy<Enum>

  /// Creates a handler whose first cached value is the current enum selection.
  ///
  /// - Parameters:
  ///   - initialValue: The complete enum value active when the selection history begins.
  ///   - fallback: The policy used when a meta case has no cached value and cannot
  ///     be constructed with `init?(fromMeta:)`.
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

  /// Gets or restores a value for the given meta case.
  func value(for meta: Enum.Meta, binding: Binding<Enum>) -> Enum {
    if binding.wrappedValue.meta == meta {
      return binding.wrappedValue
    }
    return cache[meta] ?? Enum(fromMeta: meta) ?? binding.wrappedValue
  }

  /// Switches to a new case, preserving the old value in the cache.
  ///
  /// - Returns: Whether the requested case could be represented. Returning
  ///   `true` also covers selecting the case that is already active.
  ///
  /// Example usage:
  /// ```
  /// @State private var handler = CasePathHandler<DemoTab>(
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
  
  /// Creates a case-only binding that preserves the complete value of inactive cases.
  ///
  /// The returned binding is suitable for any selection control whose values are
  /// `Enum.Meta`. Multiple controls may use bindings from the same handler. They
  /// then share one payload history even when they live in different view
  /// hierarchies.
  ///
  /// Keep the handler alive for as long as that history should last. Recreating
  /// it resets the inactive-case cache; encode separate values in application
  /// storage if the history must survive relaunch.
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
