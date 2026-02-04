//
//  WaveStack+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation
import CoreTools

public struct CodableWaveStack: Codable {
  public var waves: [String: ConfiguredWave]

  public init(_ waves: [String: ConfiguredWave]) {
    self.waves = waves
  }
}

extension WaveStack {

  /// Converts current state to a Codable projection
  public func snapshot() -> CodableWaveStack {
    print("Preparing a `CodableWaveStack` snapshot at \(Date.debug).")
    var result: [String: ConfiguredWave] = [:]

    /// Iterate the registry to see what keys we care about encoding
    for (codingKey, keyType) in WaveKeyRegistry.registeredTypes {
      print("Checking key: \(codingKey), type: \(keyType)...")
      let value = self[keyType]
      result[codingKey] = value
    }
    print("Found \(result.count) wave(s): \(result.keys.sorted())")
    return CodableWaveStack(result)
  }

  public mutating func restore(from snapshot: CodableWaveStack) {
    print("Restoring from `CodableWaveStack` at \(Date.debug). Found \(snapshot.waves.count) wave(s): \(snapshot.waves.keys.sorted())")
    
    for (key, wave) in snapshot.waves {
      print("Applying wave for key: \(key)")
      WaveKeyRegistry.apply(wave, key: key, to: &self)
    }
    print("Restore complete at \(Date.debug)")
  }
}

