//
//  StageViewConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import SwiftUI
import CoreTools
import ViewTools
import BaseTools
import ColourTools

public struct StageViewConfig: Codable, Sendable, Equatable, Hashable {
  var fishEye: ShaderEffect = .fisheyePresetA
  var fishEyeEnabled: Bool = true

  var psych: ShaderEffect = .psychPresetA
  var psychEnabled: Bool = true

  var pattern: PatternStyle

  var colour: HSVColour
  var colourSecondary: HSVColour

  var size: Double
  var sizeRange: ClosedRange<Double> = 10...100

  public var offset: CGSize
  var gap: Double
  var width: Double

  public var distortion: DistortionModel
  public var vanishingPoint: UnitPoint
  public var vanishingPointRange: ClosedRange<CGFloat>

  var degrees: Double

  var maxDrawDistance: Int = 1000
  var zoom: Double
  var yaw: Double

  public init(
    pattern: PatternStyle = .checkerboard,
    colour: HSVColour = .init(h: 0.1, s: 0.5, v: 0.4),
    colourSecondary: HSVColour = .init(h: 0.8, s: 0.5, v: 0.4),
    size: Double = 40,
    offset: CGSize = CGSize(20, 30),
    gap: Double = 40,
    width: Double = 40,
    degrees: Double = 35,
    distortion: DistortionModel = .radialDefault,
    //    perspectiveStrength: Double = 0.5,
    vanishingPoint: UnitPoint = .center,
    vanishingPointRange: ClosedRange<CGFloat> = -0.6...0.6,
    depth: Double = 20,
    zoom: Double = 10,
    yaw: Double = 40
  ) {
    self.pattern = pattern
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.size = size
    self.offset = offset
    self.gap = gap
    self.width = width
    self.degrees = degrees
    self.distortion = distortion
    //    self.perspectiveStrength = perspectiveStrength
    self.vanishingPoint = vanishingPoint
    self.vanishingPointRange = vanishingPointRange
    //    self.depth = depth
    self.zoom = zoom
    self.yaw = yaw
  }
}
