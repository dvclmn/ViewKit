//
//  WaveStack+Binding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import SwiftUI

extension WaveStack {

//  public func get<K: WaveKey>(
//    _ key: K.Type,
//    path: WritableKeyPath<K.Value, T>,
//  ) -> K.Value {
//
//  }

  /// ```
  /// stack.update(Fundamental.self) {
  ///   $0.wave.amplitude += 0.05
  ///   $0.wave.phase += delta
  /// }
  /// ```
  public mutating func update<K: WaveKey>(
    _ key: K.Type,
    _ body: (inout K.Value) -> Void
  ) {
    var value = self[key]
    body(&value)
    self[key] = value
  }

  /// ```
  /// stack.update(
  ///   HorizontalWave.self, path: \.amplitude, newValue: 0.5
  /// )
  /// ```
  public mutating func update<K: WaveKey, T>(
    _ key: K.Type,
    path: WritableKeyPath<K.Value, T>,
    newValue: T
  ) {
    var value = self[key]
    value[keyPath: path] = newValue
    self[key] = value
  }

}

extension Binding where Value == WaveStack {

  /// Creates a binding to a specific property of a `ConfiguredWave` stored in the stack
  @MainActor
  public func subBinding<K: WaveKey, T>(
    for key: K.Type,
    path: WritableKeyPath<ConfiguredWave, T>
  ) -> Binding<T> where K.Value == ConfiguredWave {
    Binding<T>(
      get: {
        /// Get the wave from the stack, then the specific property via KeyPath
        let wave = self.wrappedValue[key]
        return wave[keyPath: path]
      },
      set: { newValue in
        wrappedValue.update(key, path: path, newValue: newValue)
      }
    )
  }
}
