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

  public struct Configuration: Equatable {

    public var density: Double

    /// Like a clock / radial wipe transition shape
    public var radialCoverage: Double

    public var lineStyle: Style

    public var outerShape: Shape
    public var innerShape: Shape

    //    public var boundaryShape: BoundaryShape

    /// Internal storage uses radians for calculations
    private var _rotation: Double = 0.0

    public init(
      density: Double = 50,
      radialCoverage: Double = 1.0,
      lineStyle: Style = .init(
        colour: .init(h: 0.1, s: 0.1, v: 0.6),
        shape: .wave,
        width: 12
      ),
      outerShape: Shape = .init(radius: 1.0),
      innerShape: Shape = .init(radius: 0.2),
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

extension ActionLine.Configuration {

  /// Linear interpolation helper
  private func lerp(_ start: Double, _ end: Double, _ t: Double) -> Double {
    start + (end - start) * t
  }

}
