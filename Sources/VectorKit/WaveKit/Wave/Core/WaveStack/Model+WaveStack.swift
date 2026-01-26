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
//public struct WaveStack<Value>: @unchecked Sendable {
#warning("Try out dynamic lookup")
//@dynamicMemberLookup
public struct WaveStack: @unchecked Sendable {
  private var storage: [ObjectIdentifier: Any] = [:]

  public init() {}
}

extension WaveStack {
  public subscript<K: WaveKey>(_ key: K.Type) -> K.Value {
    get { storage[ObjectIdentifier(key)] as? K.Value ?? K.defaultValue }
    set { storage[ObjectIdentifier(key)] = newValue }
  }

  public func getConfiguredWave<K: WaveKey>(_ key: K.Type) -> ConfiguredWave? {
    self[key] as? ConfiguredWave
  }
}

// MARK: - Codable handling
extension WaveStack {

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

extension WaveStack {

  /// Internal helper for ``WaveKeyRegistry`` to inject values
  fileprivate mutating func setValue(
    _ value: ConfiguredWave,
    for keyType: any CodableWaveKey.Type
  ) {
    storage[ObjectIdentifier(keyType)] = value
  }

}

extension WaveKeyRegistry {

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
