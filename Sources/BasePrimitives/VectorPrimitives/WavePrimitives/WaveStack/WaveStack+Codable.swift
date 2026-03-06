//
//  WaveStack+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

//import CoreTools
import Foundation

public struct WaveStackSnapshot: Codable {
  public var waves: [String: ConfiguredWave]

  public init(_ waves: [String: ConfiguredWave]) {
    self.waves = waves
  }
}

extension WaveStackSnapshot {

  /// Initialise a snapshot of a WaveStack
  public init(of stack: WaveStack) {
    self = stack.snapshot()
//    let thing = stack.snapshot()
//    self.init(thing.waves)
  }

  /// Convenience apply method for “I have a snapshot, now what?”
  public func applySnapshot(to stack: inout WaveStack) {
    stack.restore(from: self)
  }
}

extension WaveStack {

  /// Converts current state to a Codable projection
  public func snapshot() -> WaveStackSnapshot {
    print("Preparing a `CodableWaveStack` snapshot at \(Date.debug).")
    var result: [String: ConfiguredWave] = [:]

    /// Iterate the registry to see what keys we care about encoding
    for (codingKey, keyType) in WaveKeyRegistry.registeredTypes {
      print("Looking for keys to regsiter. Found: \(codingKey), type: \(keyType)...")
      let value = self[keyType]
      result[codingKey] = value
    }
    print("Found \(result.count) wave(s): \(result.keys.sorted())")
    return WaveStackSnapshot(result)
  }

  public mutating func restore(from snapshot: WaveStackSnapshot) {
    print(
      "Restoring from `CodableWaveStack` at \(Date.debug). Found \(snapshot.waves.count) wave(s): \(snapshot.waves.keys.sorted())"
    )

    for (key, wave) in snapshot.waves {
      print("Applying wave for key: \(key)")
      WaveKeyRegistry.apply(wave, key: key, to: &self)
    }
    print("Restore complete at \(Date.debug)")
  }
}
