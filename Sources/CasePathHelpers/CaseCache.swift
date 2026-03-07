//
//  CaseCache.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

//import BasePrimitives
import CasePaths
import SwiftUI
import MacroHelpers

/// An alternative to the below `MetaCache`
@MainActor
@Observable
public final class CasePayloadCache<Enum: MetaEnum> {

  public var selectedMeta: Enum.Meta
  @ObservationIgnored private var lastByMeta: [Enum.Meta: Enum]

  public init(initialValue: Enum) {
    self.selectedMeta = initialValue.meta
    self.lastByMeta = [initialValue.meta: initialValue]
  }

  public func select(_ newMeta: Enum.Meta, binding: Binding<Enum>) {
    let oldValue = binding.wrappedValue
    let oldMeta = oldValue.meta
    guard oldMeta != newMeta else { return }

    /// Remember what we’re leaving.
    lastByMeta[oldMeta] = oldValue

    /// Restore if we’ve seen this case before, else create a default.
    if let restored = lastByMeta[newMeta] {
      binding.wrappedValue = restored
    } else if let fresh = Enum(fromMeta: newMeta) {
      binding.wrappedValue = fresh
    }

    selectedMeta = newMeta
  }
}

/// The below feels perhaps hacky, with the `MetaCache`?
/// A generic cache that holds the last payload for each case.
//private final class MetaCache<Enum: MetaEnum> {
//  var lastByMeta: [Enum.Meta: Enum] = [:]
//}

//extension Binding where Value: MetaEnum {
//  @MainActor
//  func metaSelection(preservingPayloads: Bool = true) -> Binding<Value.Meta> {
//    let cache = MetaCache<Value>()
//    cache.lastByMeta[self.wrappedValue.meta] = self.wrappedValue
//    return Binding<Value.Meta>(
//      get: { self.wrappedValue.meta },
//      set: { newMeta in
//        let oldValue = self.wrappedValue
//        let oldMeta = oldValue.meta
//        guard oldMeta != newMeta else { return }
//        if preservingPayloads {
//          cache.lastByMeta[oldMeta] = oldValue
//          if let restored = cache.lastByMeta[newMeta] {
//            self.wrappedValue = restored
//            return
//          }
//        }
//        // fall back to a default if we have no previous payload
//        if let fresh = Value(fromMeta: newMeta) {
//          self.wrappedValue = fresh
//        }
//      }
//    )
//  }
//}
