//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import ColourKit
import Foundation

/// Rough equivalent to `EnvironmentValues`
///
/// `stack[Fundamental.self].wave.phase += delta`
/// `stack[Fundamental.self].settings.isEnabled.toggle()`
//@dynamicMemberLookup
//public struct WaveStack<Value>: @unchecked Sendable {

public struct WaveStack: @unchecked Sendable {
  private var storage: [ObjectIdentifier: Any] = [:]

  public init() {}
}

extension WaveStack {
  public subscript<K: WaveKey>(_ key: K.Type) -> K.Value {
    get { storage[ObjectIdentifier(key)] as? K.Value ?? K.defaultValue }
    set { storage[ObjectIdentifier(key)] = newValue }
  }
  //extension WaveStack where Value == ConfiguredWave {
  //  public subscript<T>(dynamicMember keyPath: KeyPath<Self, T>) {
  //
  //  }
  //  public subscript<K: WaveKey>(_ key: K.Type) -> K.Value where K.Value == ConfiguredWave {
  //    get { storage[ObjectIdentifier(key)] as? K.Value ?? K.defaultValue }
  //    set { storage[ObjectIdentifier(key)] = newValue }
  //  }
  
  //  public subscript<T>(dynamicMember keyPath: KeyPath<Self, T>) {
  //
  //  }
}

// MARK: - Codable handling
extension WaveStack {

  /// Converts current state to a Codable projection
  public func codable() -> CodableWaveStack {
    var result: [String: ConfiguredWave] = [:]

    /// Iterate the registry to see what keys we care about encoding
    for (codingKey, keyType) in WaveKeyRegistry.all {

      /// Note: `ObjectIdentifier` is deterministic,
      /// which is why it works to initialise for checking here
      let key = ObjectIdentifier(keyType)
      
      /// Use the subscript to get the current value (or default)
      let value = storage[key] as? ConfiguredWave ?? keyType.defaultValue
      result[codingKey] = value
    }
    return CodableWaveStack(result)
  }

  public mutating func apply(_ projection: CodableWaveStack) {
    for (key, wave) in projection.waves {
      WaveKeyRegistry.apply(wave, key: key, to: &self)
    }
  }

  public func snapshot<K: CodableWaveKey>(_ key: K.Type) -> (String, ConfiguredWave) {
    (K.codingKey, self[K.self])
  }

  public mutating func restore<K: CodableWaveKey>(
    _ key: K.Type,
    from dict: [String: ConfiguredWave]
  ) {
    if let value = dict[K.codingKey] {
      self[K.self] = value
    }
  }
}

// MARK: - Registry
public enum WaveKeyRegistry {
  nonisolated(unsafe) private(set) static var all: [String: any CodableWaveKey.Type] = [:]

  public static func register<K: CodableWaveKey>(_ key: K.Type) {
    all[K.codingKey] = key
  }

  /// Helper to apply a descriptor to a stack using the type-erased key
  static func apply(
    _ wave: ConfiguredWave,
    key: String,
    to stack: inout WaveStack
  ) {
    guard let keyType = all[key] else { return }
    stack.setValue(wave, for: keyType)
  }
}

extension WaveStack {

  /// Internal helper for `WaveKeyRegistry` to inject values
  fileprivate mutating func setValue(
    _ value: ConfiguredWave,
    for keyType: any CodableWaveKey.Type
  ) {
    storage[ObjectIdentifier(keyType)] = value
  }
}
