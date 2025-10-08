//
//  Flexi+SharedKey.swift
//  BaseComponents
//
//  Created by Dave Coleman on 2/10/2025.
//

import Sharing
import SwiftUI

//extension SharedKey where Self == InMemoryKey<(any Sendable & Identifiable & Equatable)?>.Default {
//  static var singleSelection: Self {
//    Self[
//      .inMemory("singleSelection"),
//      default: nil
//    ]
//  }
//}

//extension Flexi {
//  enum SharedKeys {
//    typealias Key = InMemoryKey<Selection>.Default
//
//    static var selection: Key {
//      Key[
//        .inMemory("selection"),
//        default: .init(selectionMode: .single)
//      ]
//    }
//  }
//}

//extension SharedKey {
//  static func singleSelection<ID: Hashable & Sendable>(
//    for type: ID.Type = ID.self
//  ) -> InMemoryKey<ID?>.Default {
//    InMemoryKey<ID?>.Default[
//      .inMemory("singleSelection"),
//      default: nil
//    ]
//  }
//}
