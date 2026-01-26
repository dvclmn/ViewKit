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
  private var storage: [ObjectIdentifier: ConfiguredWave] = [:]

  public init() {}
}

extension WaveStack {
  public subscript<K: WaveKey>(_ key: K.Type) -> ConfiguredWave {
    get { storage[ObjectIdentifier(key)] ?? key.defaultValue }
    set { storage[ObjectIdentifier(key)] = newValue }
  }

  /// Internal helper for ``WaveKeyRegistry`` to inject values
  fileprivate mutating func setValue(
    _ value: ConfiguredWave,
    for keyType: any WaveKey.Type
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
