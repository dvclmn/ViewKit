//
//  MetaEnumProtocol.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftUI

/// This whole file is *one* possible solution for a Case Paths driven Picker

/// This is applied to the parent, not the Meta Enum.
public protocol MetaEnumProtocol {
  associatedtype Meta: CaseIterable & Hashable & Identifiable where Self.Meta.AllCases: RandomAccessCollection

  /// Current “case only”
  var meta: Meta { get }

  /// Build a “reasonable default” instance for this case (or nil if impossible)
  init?(fromMeta: Meta)
}

/// An alternative to the below `MetaCache`
@Observable
final class CasePickerState<Enum: MetaEnumProtocol> {
  var selectedMeta: Enum.Meta
  @ObservationIgnored var lastByMeta: [Enum.Meta: Enum]

  init(initialValue: Enum) {
    self.selectedMeta = initialValue.meta
    self.lastByMeta = [initialValue.meta: initialValue]
  }

  /// Apply a new selection and update the bound enum accordingly
  func applySelection(_ newMeta: Enum.Meta, to binding: Binding<Enum>) {
    let oldValue = binding.wrappedValue
    if oldValue.meta != newMeta {
      lastByMeta[oldValue.meta] = oldValue
      if let restored = lastByMeta[newMeta] {
        binding.wrappedValue = restored
      } else if let fresh = Enum(fromMeta: newMeta) {
        binding.wrappedValue = fresh
      }
      selectedMeta = newMeta
    }
  }
}

/// The below feels perhaps hacky, with the `MetaCache`?
/// A generic cache that holds the last payload for each case.
private final class MetaCache<Enum: MetaEnumProtocol> {
  var lastByMeta: [Enum.Meta: Enum] = [:]
}

extension Binding where Value: MetaEnumProtocol {
  @MainActor
  func metaSelection(preservingPayloads: Bool = true) -> Binding<Value.Meta> {
    let cache = MetaCache<Value>()
    cache.lastByMeta[self.wrappedValue.meta] = self.wrappedValue
    return Binding<Value.Meta>(
      get: { self.wrappedValue.meta },
      set: { newMeta in
        let oldValue = self.wrappedValue
        let oldMeta = oldValue.meta
        guard oldMeta != newMeta else { return }
        if preservingPayloads {
          cache.lastByMeta[oldMeta] = oldValue
          if let restored = cache.lastByMeta[newMeta] {
            self.wrappedValue = restored
            return
          }
        }
        // fall back to a default if we have no previous payload
        if let fresh = Value(fromMeta: newMeta) {
          self.wrappedValue = fresh
        }
      }
    )
  }
}

/// Usage:
/// ```
/// CasePicker(value: $lineShape, title: "Line Shapes") { meta in
///   Text(meta.name)
/// }
/// ```
//struct CasePicker<Value: MetaEnumProtocol, Label: View>: View {
//  @Binding var value: Value
//  var title: String
//  var preservesPayloads: Bool = true
//  @ViewBuilder var labelForMeta: (Value.Meta) -> Label
//
//  var body: some View {
//    Picker(title, selection: $value.metaSelection(preservingPayloads: preservesPayloads)) {
//      ForEach(Value.Meta.allCases) { meta in
//        labelForMeta(meta).tag(meta)
//      }
//    }
//  }
//}

//extension Binding where Value: MetaEnumProtocol {
//  /// A binding to “which case is selected?”, with optional per-case payload preservation.
//  public func metaSelection(preservingPayloads: Bool = true) -> Binding<Value.Meta> {
//    /// Local cache lives *inside* the returned Binding via captured reference type.
//    final class Cache {
//      var lastByMeta: [Value.Meta: Value] = [:]
//    }
//    let cache = Cache()
//
//    // Seed cache with the current value so “switch away and back” can restore.
//    cache.lastByMeta[self.wrappedValue.meta] = self.wrappedValue
//
//    return Binding<Value.Meta>(
//      get: { self.wrappedValue.meta },
//      set: { newMeta in
//        let oldValue = self.wrappedValue
//        let oldMeta = oldValue.meta
//
//        /// If you re-select the same case, do nothing (keeps payload intact).
//        guard newMeta != oldMeta else { return }
//
//        if preservingPayloads {
//          /// Remember the full payload for the case we’re leaving.
//          cache.lastByMeta[oldMeta] = oldValue
//
//          /// If we’ve seen this case before, restore its last payload.
//          if let restored = cache.lastByMeta[newMeta] {
//            self.wrappedValue = restored
//            return
//          }
//        }
//
//        /// Otherwise, fall back to “default instance for the case”.
//        if let fresh = Value(fromMeta: newMeta) {
//          self.wrappedValue = fresh
//        }
//      }
//    )
//  }
//}
