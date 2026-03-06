//
//  WaveStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

// import ColourKit
import Foundation

public struct WaveLineStyle: Codable, Sendable, Equatable, Hashable {
  public var colour: RGBColour
  public var colourSecondary: RGBColour?
  public var lineWidth: Double
  public var dashes: Int
  public var dashGap: Double
  public var dashPhase: Double

  public init(
    colour: RGBColour = .green,
    colourSecondary: RGBColour? = .orange,
    lineWidth: Double = 3.0,
    dashes: Int = 0,
    dashGap: Double = 0,
    dashPhase: Double = 0,
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.lineWidth = lineWidth
    self.dashes = dashes
    self.dashGap = dashGap
    self.dashPhase = dashPhase
  }
}

extension WaveLineStyle {
  public static var example: Self {
    .init(
      colour: .green,
      colourSecondary: .brown,
      lineWidth: 3.0,
    )
  }
}
