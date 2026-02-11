//
//  WaveKeyRegistry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

/// Do this once at app launch:
/// ```
/// WaveRegistry.register(VerticalWave.self)
/// WaveRegistry.register(DotRadiusWave.self)
/// WaveRegistry.register(HorizontalWave.self)
/// WaveRegistry.register(MainWave.self)
/// ```
///
/// Then ``WaveStack/snapshot()`` iterates over registered keys
/// ```
/// for (codingKey, layer) in decoded.waves {
///   if let keyType = WaveKeyRegistry.all[codingKey] {
///     stack[keyType] = layer
///   }
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

extension WaveKeyRegistry {

  /// Helper to apply a `ConfiguredWave` to a stack using the type-erased key
  static func apply(
    _ wave: ConfiguredWave,
    key: String,
    to stack: inout WaveStack
  ) {
    guard let keyType = registeredTypes[key] else { return }
    stack.setValue(wave, for: keyType)
  }
}
