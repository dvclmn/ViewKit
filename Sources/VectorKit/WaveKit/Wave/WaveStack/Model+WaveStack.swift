//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import ColourKit
import SwiftUI

/// Rough equivalent to `EnvironmentValues`
///
/// `stack[Fundamental.self].wave.phase += delta`
/// `stack[Fundamental.self].settings.isEnabled.toggle()`
// TODO: Try out dynamic lookup?
//@dynamicMemberLookup
public struct WaveStack: @unchecked Sendable, Equatable, Identifiable, Hashable {
  public let id: UUID
  private var storage: [ObjectIdentifier: ConfiguredWave] = [:]

  public init() {
    self.id = UUID()
  }
}

extension WaveStack {
  public subscript<K: WaveKey>(_ key: K.Type) -> ConfiguredWave {
    get { storage[ObjectIdentifier(key)] ?? key.defaultValue }
    set { storage[ObjectIdentifier(key)] = newValue }
  }

  /// Internal helper for ``WaveKeyRegistry`` to inject values
  /// For use by `WaveKeyRegistry` only
  package mutating func setValue(
    _ value: ConfiguredWave,
    for keyType: any WaveKey.Type
  ) {
    storage[ObjectIdentifier(keyType)] = value
  }
}

extension WaveStack {
  public init(restoring snapshot: WaveStackSnapshot) {
    self.init()
    self.restore(from: snapshot)
  }
}

extension Binding where Value == WaveStack {
  @MainActor
  public func waveBinding<K: WaveKey, T>(
    _ key: K.Type,
    _ keyPath: WritableKeyPath<ConfiguredWave, T> = \.self
  ) -> Binding<T> {
    Binding<T> {
      wrappedValue[key][keyPath: keyPath]
    } set: { newValue in
      wrappedValue[key][keyPath: keyPath] = newValue
    }
  }
}
