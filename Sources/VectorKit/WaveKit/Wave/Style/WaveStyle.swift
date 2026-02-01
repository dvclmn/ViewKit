//
//  WaveStyle.swift
//  BaseDemos
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import CoreTools
import Foundation

public struct WaveStyle: Sendable, Codable, Equatable, Hashable {
  public var lineStyle: LineStyle
  public var pointStyle: PointStyle

  public init(
    line: LineStyle = .init(),
    point: PointStyle = .init(),
  ) {
    self.lineStyle = line
    self.pointStyle = point
  }
}

extension WaveStyle {
  public func getSecondaryColourOrFallBack(
    for component: WaveDisplayComponent.Meta,
    fallback: HSVColour = .brown
  ) -> HSVColour {
    switch component {
      case .line: lineStyle.colourSecondary ?? fallback
      case .points: pointStyle.colourSecondary ?? fallback
      default: fallback
    }
  }

  public func getColour(
    for component: WaveDisplayComponent.Meta,
    level: ColourLevel
  ) -> HSVColour {
    switch component {
      case .line:
        return level.isForeground
          ? lineStyle.colour.toHSV
          : getSecondaryColourOrFallBack(for: component).toHSV

      case .points:
        return level.isForeground
          ? pointStyle.colour.toHSV
          : getSecondaryColourOrFallBack(for: component).toHSV

      default:
        print("Doesn't apply here")
        return HSVColour(h: 0.2, s: 0.6, v: 0.5)
    }

  }

  public mutating func setColour(
    _ colour: HSVColour,
    for component: WaveDisplayComponent.Meta,
    level: ColourLevel
  ) {
    switch component {
      case .line:

        if level.isForeground {
          lineStyle.colour = colour

        } else {
          lineStyle.colourSecondary = colour
        }

      case .points:
        if level.isForeground {
          pointStyle.colour = colour

        } else {
          pointStyle.colourSecondary = colour

        }
      default: return
    }
  }

}
