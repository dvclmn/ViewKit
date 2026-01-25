//
//  WaveStack+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct CodableWaveStack: Codable {
  public var waves: [String: WaveDescriptor]

  public init(_ waves: [String: WaveDescriptor]) {
    self.waves = waves
  }
}
