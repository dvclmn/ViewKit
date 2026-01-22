//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct Wave: WaveShaped, Sendable, Identifiable, Hashable, Codable {
  public let id: UUID
  public var frequency: Double
  public var amplitude: Double
  public var phase: Double

}

public struct NoisyWave: Sendable, Hashable {
  public let wave: Wave
  public var noise: Double
}
