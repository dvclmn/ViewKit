//
//  Model+Hover.swift
//  BaseComponents
//
//  Created by Dave Coleman on 18/5/2025.
//

import Foundation

public struct Hover3DState: Sendable {
  public var normalisedPoint: CGPoint  // -1...1 in both axes
  public var hoverPoint: CGPoint  // raw hover location
  public var distanceFromCentre: CGFloat
  public var rotationAngle: Double  // already computed

  public func viewScale(strength: CGFloat = 0.06) -> CGFloat {
    //    if let hoverState {
    return 1 + CGFloat(distanceFromCentre) * strength
    //    } else {
    //      return 1
    //    }
  }

  public static let inert = Hover3DState(
    normalisedPoint: .zero,
    hoverPoint: .zero,
    distanceFromCentre: 0,
    rotationAngle: 0
  )

  public func viewOffset(strength: CGFloat = 8) -> CGPoint {
    //    if let hoverState {
    return CGPoint(
      x: normalisedPoint.x * strength,
      y: normalisedPoint.y * strength
    )
    //    } else {
    //      return .zero
    //    }
  }

}
