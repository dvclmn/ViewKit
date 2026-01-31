//
//  WaveStyle.swift
//  BaseDemos
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import CoreTools
import Foundation

//import GraphicsKit

public struct WaveStyle: Sendable, Codable, Equatable, Hashable {
  public var lineStyle: LineStyle
  public var pointStyle: PointStyle

  //  var shader: ShaderEffect
  //  var shaderB: ShaderEffect
  //  var isShaderEnabled: Bool = true

  public init(
    line: LineStyle = .init(),
    point: PointStyle = .init(),
    //    shader: ShaderEffect = .chromaticPresetA,
    //    shaderB: ShaderEffect = .ripplePush(l: .quickPreset01, v: .quickPreset02)
  ) {
    self.lineStyle = line
    self.pointStyle = point
    //    self.shader = shader
    //    self.shaderB = shaderB
  }
}

extension WaveStyle {
  public func getSecondaryColourOrFallBack(
    for component: WaveDisplayComponent.Meta,
    fallback: HSVColour = .brown
      //    fallback: RGBColour = .brown
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
    //    hue: Double?,
    //    saturation: Double?,
    //    brightness: Double?,
    for component: WaveDisplayComponent.Meta,
    level: ColourLevel
  ) {
    //  public mutating func setColour(
    //    hue: Double?,
    //    saturation: Double?,
    //    brightness: Double?,
    //    for component: WaveComponent.Meta,
    //    level: ColourLevel
    //  ) {

    switch component {
      case .line:

        if level.isForeground {
          lineStyle.colour = colour
          //          lineStyle.colour.set(
          //            hue: hue,
          //            saturation: saturation,
          //            brightness: brightness
          //          )

        } else {
          lineStyle.colourSecondary = colour
        }

      case .points:
        if level.isForeground {
          pointStyle.colour = colour
          //          pointStyle.colour.set(
          //            hue: hue,
          //            saturation: saturation,
          //            brightness: brightness
          //          )

        } else {
          pointStyle.colourSecondary = colour
          //          pointStyle.colourSecondary?.set(
          //            hue: hue,
          //            saturation: saturation,
          //            brightness: brightness
          //          )
        }
      default: return
    }
  }

}
