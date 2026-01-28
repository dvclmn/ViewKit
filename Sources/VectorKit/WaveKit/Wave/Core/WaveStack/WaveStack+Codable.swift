//
//  WaveStack+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation
import MetaCodable

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

//struct WaveStackCoder: MetaCodable.HelperCoder {
//  /// Decode from the serializable projection back to the type-safe stack
//  func decode(from decoder: Decoder) throws -> WaveStack {
//    let snapshot = try CodableWaveStack(from: decoder)
//    var stack = WaveStack()
//    stack.restore(from: snapshot)
//    return stack
//  }
//
//  /// Encode the type-safe stack to its serializable projection
//  func encode(_ value: WaveStack, to encoder: Encoder) throws {
//    try value.snapshot().encode(to: encoder)
//  }
//}
//
//// If MetaCodable requires it to be Sendable (check your version):
//extension WaveStackCoder: Sendable {}
//
//struct FailableWaveKeyCoder: MetaCodable.HelperCoder {
//  func decode(from decoder: Decoder) throws -> AnyWaveKey? {
//    // Returns nil instead of throwing for unknown keys
//    // Useful for forward compatibility
//    guard let type = WaveKeyRegistry.lookup(identifier) else {
//      return nil // Or log and return a placeholder
//    }
//    return AnyWaveKey(type)
//  }
//}
