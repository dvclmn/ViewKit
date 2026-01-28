//
//  WaveStack+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct CodableWaveStack: Codable {
  public var waves: [String: ConfiguredWave]

  public init(_ waves: [String: ConfiguredWave]) {
    self.waves = waves
  }
}

extension WaveStack {

  /// Converts current state to a Codable projection
  public func snapshot() -> CodableWaveStack {
    var result: [String: ConfiguredWave] = [:]

    /// Iterate the registry to see what keys we care about encoding
    for (codingKey, keyType) in WaveKeyRegistry.registeredTypes {

      let value = self[keyType]
      result[codingKey] = value
    }
    return CodableWaveStack(result)
  }

  public mutating func restore(from snapshot: CodableWaveStack) {
    for (key, wave) in snapshot.waves {
      WaveKeyRegistry.apply(wave, key: key, to: &self)
    }
  }

}
