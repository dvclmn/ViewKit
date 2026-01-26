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
//  public func codable() -> CodableWaveStack {
//    var result: [String: ConfiguredWave] = [:]
//    
//    /// Iterate the registry to see what keys we care about encoding
//    for (codingKey, keyType) in WaveKeyRegistry.all {
//      
//      
//      /// Note: `ObjectIdentifier` is deterministic,
//      /// which is why it works to initialise for checking here
////      let key = ObjectIdentifier(keyType)
////      
////      /// Use the subscript to get the current value (or default)
////      //      let value = self[key] as? ConfiguredWave ?? keyType.defaultValue
////      let value = self.getConfiguredWave(key)
////      result[codingKey] = value
//      
//      let value = self[keyType]
//      result[codingKey] = value
//    }
//    return CodableWaveStack(result)
//  }
  
}
