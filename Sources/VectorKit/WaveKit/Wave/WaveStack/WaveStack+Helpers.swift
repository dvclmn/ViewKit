//
//  WaveStack+Binding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import SwiftUI

//extension WaveStack {
//
//  /// ```
//  /// stack.update(Fundamental.self) {
//  ///   $0.wave.amplitude += 0.05
//  ///   $0.wave.phase += delta
//  /// }
//  /// ```
//  public mutating func update<K: WaveKey>(
//    _ key: K.Type,
//    _ body: (inout ConfiguredWave) -> Void
//  ) {
//    var value = self[key]
//    body(&value)
//    self[key] = value
//  }
//
//  /// ```
//  /// stack.update(
//  ///   HorizontalWave.self, path: \.amplitude, newValue: 0.5
//  /// )
//  /// ```
//  public mutating func update<K: WaveKey, T>(
//    _ key: K.Type,
//    path: WritableKeyPath<ConfiguredWave, T>,
//    newValue: T
//  ) {
//    var value = self[key]
//    value[keyPath: path] = newValue
//    self[key] = value
//  }
//}
