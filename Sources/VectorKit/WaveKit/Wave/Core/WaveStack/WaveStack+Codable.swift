//
//  WaveStack+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct CodableWaveStack: Codable {
  public var waves: [String: WaveDescriptor]
}

extension WaveStack {
  public func codable() -> CodableWaveStack {
    var result: [String: WaveLayer] = [:]
    
    for (id, value) in storage {
      if let entry = value as? any CodableWaveEntry {
        result[entry.codingKey] = entry.waveLayer
      }
    }
    
    return CodableWaveStack(waves: result)
  }
  
  mutating func apply(_ codable: CodableWaveStack) {
    for (key, layer) in codable.waves {
      applyDecodedWave(key: key, layer: layer)
    }
  }
}
