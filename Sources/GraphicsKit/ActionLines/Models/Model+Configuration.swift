//
//  Model+Configuration.swift
//  Components
//
//  Created by Dave Coleman on 25/11/2024.
//

import SwiftUI

public struct ActionLineConfigurations {

  public var density: Double
  public var radialCoverage: Double

  public var lineStyle: ActionLineStyle

  public var outerShape: ActionLineShape
  public var innerShape: ActionLineShape

  public var boundaryShape: BoundaryShape

  /// Internal storage uses radians for calculations
  private var _rotation: Double = 0.0

  public init(
    density: Double = 50,
    radialCoverage: Double = 1.0,
    lineStyle: ActionLineStyle = .init(color: .black, width: 2),
    outerShape: ActionLineShape = .init(radius: 1.0),
    innerShape: ActionLineShape = .init(radius: 0.2),
    boundaryShape: BoundaryShape = .square,
  ) {
    self.density = density
    self.radialCoverage = radialCoverage
    self.lineStyle = lineStyle
    self.outerShape = outerShape
    self.innerShape = innerShape
    self.boundaryShape = boundaryShape
  }
}

extension ActionLineConfigurations {

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

extension ActionLineConfigurations {

  /// Linear interpolation helper
  private func lerp(_ start: Double, _ end: Double, _ t: Double) -> Double {
    start + (end - start) * t
  }

}
