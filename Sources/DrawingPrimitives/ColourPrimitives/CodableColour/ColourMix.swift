//
//  ColourPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

public struct ColourMix: Sendable, Codable, Equatable, Hashable {

  public let base: SystemColour
  public let mix: SystemColour
  public let mixAmount: Double

  public init(
    _ base: SystemColour,
    _ mix: SystemColour,
    mixAmount: Double = 0.5,
  ) {
    self.base = base
    self.mix = mix
    self.mixAmount = mixAmount
  }

  public var colour: Color { base.withMix(mix, mixAmount) }
}
extension ColourMix {

  public static let greenNeon: Self = .init(
    .green,
    .yellow,
    mixAmount: 0.36,
  )

  public static let pinkNeon: Self = .init(
    .pink,
    .blue,
    mixAmount: 0.46,
  )
}
