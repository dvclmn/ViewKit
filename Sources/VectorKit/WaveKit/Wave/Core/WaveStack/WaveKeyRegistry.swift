//
//  WaveKeyRegistry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

//public struct WaveEntry: Sendable {
//  let codingKey: String
//  let defaultValue: ConfiguredWave
//  let path: WritableKeyPath<WaveStack, ConfiguredWave>
//}
//
//public enum WaveRegistry {
//  static let all: [WaveEntry] = [
//    .init(
//      codingKey: "fundamental",
//      defaultValue: .fundamental,
//      path: \.fundamental
//    ),
//    .init(
//      codingKey: "harmonic",
//      defaultValue: .harmonic,
//      path: \.harmonic
//    )
//  ]
//}

/// Usage (once, at app startup):
/// ```
/// WaveKeyRegistry.register(Fundamental.self)
/// WaveKeyRegistry.register(Harmonic2.self)
/// ```
///
/// ```
/// for (codingKey, layer) in decoded.waves {
///   if let keyType = WaveKeyRegistry.all[codingKey] {
///     stack[keyType] = layer
///   }
/// }
/// ```
public enum WaveKeyRegistry {
  nonisolated(unsafe)
  private(set) static var all: [String: any WaveKey.Type] = [:]

  public static func register<K: WaveKey>(_ key: K.Type) {
    all[K.codingKey] = key
  }

}
