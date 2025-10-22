//
//  ColourPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

public struct ColourPreset: Sendable, Codable, Equatable, Hashable {
  public let base: SystemColour
  public let mix: SystemColour?
  public let hsvAdjustment: HSVAdjustment?
  public let mixAmount: Double
  public let opacity: Double

  public init(
    _ base: SystemColour,
    mix: SystemColour? = nil,
    mixAmount: Double = 0.5,
    hsvAdjustment: HSVAdjustment? = nil,
    opacity: Double = 1.0
  ) {
    self.base = base
    self.mix = mix
    self.mixAmount = mixAmount
    self.hsvAdjustment = hsvAdjustment
    self.opacity = opacity
  }

  public var colour: Color {
    guard let mix else { return base.toColour }
    let mixed = base.withMix(mix, mixAmount).opacity(opacity)

    guard let hsvAdjustment else {
      return mixed
    }
    return mixed.hsvAdjusted(by: hsvAdjustment) ?? mixed
  }
}
extension ColourPreset {

  public static let greenNeon: ColourPreset = ColourPreset(
    .green,
    mix: .yellow,
    mixAmount: 0.36,
    //    mixAmount: -0.7,
    hsvAdjustment: .init(s: -0.16, v: -0.16),
    //        hsvAdjustment: .init(h: 1.34, v: -0.2),
    //    opacity: 0.84,
  )
}
