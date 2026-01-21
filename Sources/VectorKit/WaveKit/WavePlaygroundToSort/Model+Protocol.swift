//
//  Model+Protocol.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import Foundation

public protocol WaveAnimatable: Codable {
  // Should the modulation be applied?
  var isEnabled: Bool { get }
  // How big the effect is (in points)
  var amplitude: CGFloat { get }
  // The speed of the wave (in cycles per second, sort of)
  var speed: Double { get }
  // An extra phase offset (in radians)
  var phase: Double { get }
  // How many cycles (periods) should be “laid out” over your domain,
  // for example the normalised index running from 0 to 1.
  var cycles: Double { get }
  
  // Compute the modulation value given the current time and a normalised index
  // (For example, if your property should vary by a sine wave that “travels”
  // over time while also “spanning” a fixed number of cycles over your circles,
  // you can use this value directly.)
  func modulation(effectiveTime: TimeInterval, normalisedIndex: Double) -> CGFloat
}

extension WaveAnimatable {
  public func modulation(effectiveTime: TimeInterval, normalisedIndex: Double) -> CGFloat {
    guard isEnabled else { return 0 }
    let argument = effectiveTime * speed +
    normalisedIndex * (2 * .pi * cycles) +
    phase
    return amplitude * CGFloat(sin(argument))
  }
}


public struct WaveModulator: WaveAnimatable, Codable {
  public var isEnabled: Bool
  public var amplitude: CGFloat
  public var speed: Double
  public var phase: Double
  public var cycles: Double
}

