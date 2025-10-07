//
//  Model+Configuration.swift
//  Components
//
//  Created by Dave Coleman on 25/11/2024.
//

import SwiftUI

struct ActionLineShape {
  var radius: Double
  var position: CGPoint? = nil
  var variation: Double = 0.0
  // Future properties:
  // var capStyle: CapStyle
  // var thickness: Double
}

struct ActionLineConfigurations {
  
  var density: Double = 50
  var radialCoverage: Double = 1.0
  
  var lineStyle: ActionLineStyle = .init(color: .black, width: 2)
  
  var outerShape: ActionLineShape = .init(radius: 1.0)
  var innerShape: ActionLineShape = .init(radius: 0.2)
  
  var boundaryShape: BoundaryShape = .square
  
  
  // MARK: - Rotation
  /// Internal storage uses radians for calculations
  private var _rotation: Double = 0.0
  
  /// Normalized rotation (0.0 to 1.0, represents one full turn)
  var rotation: Double {
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

