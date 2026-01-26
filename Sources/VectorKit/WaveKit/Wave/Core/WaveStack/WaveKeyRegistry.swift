//
//  WaveKeyRegistry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

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
  private(set) static var all: [String: any CodableWaveKey.Type] = [:]

  public static func register<K: CodableWaveKey>(_ key: K.Type) {
    all[K.codingKey] = key
  }

}
