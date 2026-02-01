//
//  WaveStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

public struct LineStyle: Sendable, Codable, Equatable, Hashable {
  public var colour: HSVColour
  public var colourSecondary: HSVColour?
  public var lineWidth: Float
  public var dashes: Int
  public var dashPhase: Float

  public init(
    colour: HSVColour = .green,
    colourSecondary: HSVColour? = .orange,
    lineWidth: Float = 3.0,
    dashes: Int = 0,
    dashPhase: Float = 0,
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.lineWidth = lineWidth
    self.dashes = dashes
    self.dashPhase = dashPhase
  }
}

extension LineStyle {
  public static let example: Self = .init(
    colour: .green,
    colourSecondary: .brown,
    lineWidth: 3.0,
  )
}
