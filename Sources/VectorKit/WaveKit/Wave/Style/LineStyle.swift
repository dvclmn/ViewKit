//
//  WaveStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

public typealias FloatLineStyle = LineStyle<Double>
//public typealias FloatPointStyle = PointStyle<Float>

public struct LineStyle<T: WaveFloat>: Codable, Sendable, Equatable, Hashable {
  public var colour: HSVColour
  public var colourSecondary: HSVColour?
  public var lineWidth: T
  public var dashes: Int
  public var dashPhase: T

  public init(
    colour: HSVColour = .green,
    colourSecondary: HSVColour? = .orange,
    lineWidth: T = 3.0,
    dashes: Int = 0,
    dashPhase: T = 0,
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.lineWidth = lineWidth
    self.dashes = dashes
    self.dashPhase = dashPhase
  }
}

extension LineStyle {
  public static var example: Self {
    .init(
      colour: .green,
      colourSecondary: .brown,
      lineWidth: 3.0,
    )
  }
}
