//
//  ColourPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

public protocol CodableColour: Codable, Equatable, Hashable {
  var colour: Color { get }
}

public struct ColourPreset: Sendable, Codable, Equatable, Hashable, CodableColour {

  /// The colours to mix
  public let colours: [SystemColour]
  public let adjustment: HSVAdjustment?
  public let mixAmount: Double
  public let opacity: Double

  //  public init(
  //    _ base: SystemColour,
  //    mix: SystemColour? = nil,
  //    mixAmount: Double = 0.5,
  //    adjustment: HSVAdjustment? = nil,
  //    opacity: Double = 1.0
  //  ) {
  //    self.base = base
  //    self.mix = mix
  //    self.mixAmount = mixAmount
  //    self.adjustment = adjustment
  //    self.opacity = opacity
  //  }

  public init(
    _ colourList: SystemColour...,
    mixAmount: Double = 0.5,
    adjustment: HSVAdjustment? = nil,
    opacity: Double = 1.0
  ) {
    let list = colourList.map { $0 }
    precondition(!list.isEmpty)

    self.colours = list
    self.mixAmount = mixAmount
    self.adjustment = adjustment
    self.opacity = opacity
  }

  public var colour: Color {

    let mixed = colours.reduce(into: Color.clear) { partial, sysColour in
      partial = partial.mixCompatible(with: sysColour.toColour, by: mixAmount)
    }

    guard let adjustment else {
      return mixed
    }
    return mixed.hsvAdjusted(by: adjustment) ?? mixed
  }
}
extension ColourPreset {

  public static let greenNeon: ColourPreset = ColourPreset(
    .green,
    .yellow,
    mixAmount: 0.36,
    adjustment: .init(s: -0.16, v: -0.16)
  )

  public static let pinkNeon: ColourPreset = ColourPreset(
    .pink,
    .blue,
    mixAmount: 0.46,
    adjustment: .init(s: -0.4, v: -0.2)
  )
}
