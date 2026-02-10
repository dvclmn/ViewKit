//
//  Model+Configuration.swift
//  Components
//
//  Created by Dave Coleman on 25/11/2024.
//

import ColourKit
import MetaCodable
import SwiftUI
import Yams

public enum ActionLine {}

extension ActionLine {

  /// Attributes of the full Action Lines collective.
  /// For style of individual lines, see ``ActionLine/LineStyle``
  @Codable
  public struct Configuration: Equatable, Sendable, Codable {

    public var density: Double

    /// Like a clock / radial wipe transition shape
    public var radialCoverage: Double

    public var lineStyle: LineStyle

    public var outerShape: BoundaryStyle
    public var innerShape: BoundaryStyle

    @IgnoreCoding
//    public var shaders: Set<ShaderEffect> = [
    public var shaders: [ShaderEffect] = [
      .chromaticSubtle,
      .crtCurvature(k1: 2.0, k2: 2.0),
      .crtLines(),
      .crtCurvature(k1: 0.5, k2: 0.5),
    ]

    //    @IgnoreCoding
    //    public var chrom: ShaderEffect = .chromaticSubtle
    //
    //    @IgnoreCoding
    //    public var shaderB: ShaderEffect = .crtLines()
    //
    //    @IgnoreCoding
    //    public var shaderC: ShaderEffect = .crtCurvature(k1: 2.0, k2: 2.0, origin: .zero)

    /// Internal storage uses radians for calculations
    @IgnoreCoding
    private var _rotation: Double = 0.0

    public init(
      density: Double,
      radialCoverage: Double = 1.0,
      lineStyle: LineStyle,
      outerShape: BoundaryStyle,
      innerShape: BoundaryStyle,
    ) {
      self.density = density
      self.radialCoverage = radialCoverage
      self.lineStyle = lineStyle
      self.outerShape = outerShape
      self.innerShape = innerShape
    }
  }
}

extension ActionLine.Configuration {
  /// Alternative convenience init
  public init(
    density: Double,
    minWidth: Double,
    maxWidth: Double,
    cycles: Double,
    shape: LineShape,
    radiusInner: Double,
    colourInner: RGBColour,
    variantionInner: Double,
    radiusOuter: Double,
    colourOuter: RGBColour,
    variantionOuter: Double,
  ) {

    let lineStyle = ActionLine.LineStyle(
      shape: shape,
      minWidth: minWidth,
      maxWidth: maxWidth,
      cycles: cycles
    )
    let inner = ActionLine.BoundaryStyle(
      radius: radiusInner,
      variation: variantionInner,
      colour: colourInner,
    )
    let outer = ActionLine.BoundaryStyle(
      radius: radiusOuter,
      variation: variantionOuter,
      colour: colourOuter,
    )
    self.init(
      density: density,
      lineStyle: lineStyle,
      outerShape: inner,
      innerShape: outer
    )
  }

  /// Normalized rotation (0.0 to 1.0, represents one full turn)
  public var rotation: Double {
    get { _rotation / (2 * .pi) }
    set {

      _rotation = (newValue * 2 * .pi).truncatingRemainder(dividingBy: 2 * .pi)
    }
  }
  /// Degree-based rotation (0 to 360)
  var rotationDegrees: Double {
    get { rotation * 360 }
    set { rotation = (newValue / 360).truncatingRemainder(dividingBy: 1) }
  }
}
