//
//  MetaEnumProtocol.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import CasePaths
import SwiftUI

/// This whole file is *one* possible solution for a Case Paths driven Picker

public enum MetaEnum {

  /// This is applied to the parent, not the Meta Enum.
  public protocol Parent {
    associatedtype Child: Meta

    /// Current “case only”
    var meta: Child { get }

    /// Build a “reasonable default” instance for this case (or nil if impossible)
    init?(fromMeta: Child)
  }

  public protocol Meta: CaseIterable, Hashable, Identifiable where AllCases: RandomAccessCollection {
    var name: String { get }
  }

}

//public protocol

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
