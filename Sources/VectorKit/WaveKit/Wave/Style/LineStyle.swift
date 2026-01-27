//
//  WaveStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

public struct LineStyle: Sendable, Codable, Equatable {
  public var colour: HSVColour
  public var colourSecondary: HSVColour?
  public var lineWidth: CGFloat

  public init(
    colour: HSVColour = .green,
    colourSecondary: HSVColour? = .orange,
    lineWidth: CGFloat = 3.0
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.lineWidth = lineWidth
  }
}

extension LineStyle {
  public static let example: Self = .init(
    colour: .green,
    colourSecondary: .brown,
    lineWidth: 3.0,
  )
}
