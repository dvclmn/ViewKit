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

  nonisolated(unsafe)
    public static var registeredTypes: [String: any WaveKey.Type] = [:]

  public static func register<T: WaveKey>(_ type: T.Type) {
    registeredTypes[T.codingKey] = type
  }

  static func lookup(_ key: String) -> (any WaveKey.Type)? {
    return registeredTypes[key]
  }
}
