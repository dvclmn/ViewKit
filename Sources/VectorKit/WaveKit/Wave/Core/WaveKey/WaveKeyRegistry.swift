//
//  WaveKeyRegistry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

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
/// ```
/// // Do this once at app launch
/// WaveRegistry.register(VerticalWave.self)
/// WaveRegistry.register(DotRadiusWave.self)
/// WaveRegistry.register(HorizontalWave.self)
/// WaveRegistry.register(MainWave.self)
///
/// // Now your struct just works!
/// struct BreathingPreferences: Sendable, Codable {
///   var enabledWaves: [AnyWaveKey: Bool] = [:]
/// }
/// ```
public enum WaveKeyRegistry {
  // A map of "codingKey" string -> Metatype
  nonisolated(unsafe)
  public static var registeredTypes: [String: any WaveKey.Type] = [:]
//  private static var registeredTypes: [String: any WaveKey.Type] = [:]

  public static func register<T: WaveKey>(_ type: T.Type) {
    registeredTypes[T.codingKey] = type
  }

  static func lookup(_ key: String) -> (any WaveKey.Type)? {
    return registeredTypes[key]
  }

  //  nonisolated(unsafe)
  //  private(set) static var all: [String: any WaveKey.Type] = [:]
  //
  //  public static func register<K: WaveKey>(_ key: K.Type) {
  //    all[K.codingKey] = key
  //  }

}

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

//extension WaveStack {
//  func snapshot() -> CodableWaveStack {
//    var result: [String: ConfiguredWave] = [:]
//
//    for entry in WaveRegistry.all {
//      result[entry.codingKey] = self[keyPath: entry.path]
//    }
//
//    return CodableWaveStack(result)
//  }
//
//  mutating func restore(from snapshot: CodableWaveStack) {
//    for entry in WaveRegistry.all {
//      if let wave = snapshot.waves[entry.codingKey] {
//        self[keyPath: entry.path] = wave
//      }
//    }
//  }
//}
