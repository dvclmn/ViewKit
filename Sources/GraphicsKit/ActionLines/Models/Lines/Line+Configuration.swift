//
//  Model+Configuration.swift
//  Components
//
//  Created by Dave Coleman on 25/11/2024.
//

import ColourKit
import SwiftUI

public enum ActionLine {}

extension ActionLine {

  /// Attributes of the full Action Lines collective.
  /// For style of individual lines, see ``ActionLine/LineStyle``
  public struct Configuration: Equatable, Sendable, Codable {

    public var density: Double

    /// Like a clock / radial wipe transition shape
    public var radialCoverage: Double

    public var lineStyle: LineStyle

    public var outerShape: BoundaryStyle
    public var innerShape: BoundaryStyle

    /// Internal storage uses radians for calculations
    private var _rotation: Double = 0.0

    public init(
      density: Double,
      radialCoverage: Double,
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
