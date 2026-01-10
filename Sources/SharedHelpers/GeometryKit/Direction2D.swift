//
//  Direction2D.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

public struct Direction2D: Sendable, Hashable {
  public let x: CGFloat
  public let y: CGFloat
}

extension Direction2D {
  public static let up = Direction2D(x: 0, y: -1)
  public static let down = Direction2D(x: 0, y: 1)
  public static let leading = Direction2D(x: -1, y: 0)
  public static let trailing = Direction2D(x: 1, y: 0)

  public static let centre = Direction2D(x: 0, y: 0)

  public static let topLeading = Direction2D(x: -1, y: -1)
  public static let topTrailing = Direction2D(x: 1, y: -1)
  public static let bottomLeading = Direction2D(x: -1, y: 1)
  public static let bottomTrailing = Direction2D(x: 1, y: 1)
}

extension Direction2D {
  public func offset(
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGSize {
    let multiplier: CGFloat = (radialDirection == .outward) ? 1 : -1
    return CGSize(
      width: x * distance * multiplier,
      height: y * distance * multiplier
    )
  }

  public func offset(
    axis: Axis2D,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGFloat {
    let offset = offset(distance: distance, radial: radialDirection)
    return axis.isHorizontal ? offset.width : offset.height
//    let multiplier: CGFloat = (radialDirection == .outward) ? 1 : -1
//    let offset: CGFloat = axis.isHorizontal ? x : y
//
//    return offset * distance * multiplier
    //    CGSize(
    //      width: x * distance * multiplier,
    //      height: y * distance * multiplier
    //    )
  }

  public func positioned(
    from origin: CGPoint,
    alignment: Alignment,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGPoint {
    let delta = alignment.offset(distance: distance, radial: radialDirection)
    return CGPoint(
      x: origin.x + delta.width,
      y: origin.y + delta.height
    )
  }

}

public enum RadialDirection: Sendable {
  case outward
  case inward
}

extension Alignment {
  public var direction: Direction2D {
    switch self {
      case .top: .up
      case .bottom: .down
      case .leading: .leading
      case .trailing: .trailing
      case .topLeading: .topLeading
      case .topTrailing: .topTrailing
      case .bottomLeading: .bottomLeading
      case .bottomTrailing: .bottomTrailing
      case .center: .centre
      default: .centre
    }
  }

  public func offset(
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGSize {
    direction.offset(distance: distance, radial: radialDirection)
  }
  
  public func offset(
    axis: Axis2D,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGSize {
    direction.offset(axis: axis, distance: distance, radial: radialDirection)
  }

}

extension ViewDimensions {
  public func offset(
    for alignment: Alignment,
    axis: Axis2D,
    magnitude: CGFloat,  // As a factor, e.g. 0.2
    //    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGFloat {
    let length = axis.isHorizontal ? self.width : self.height
    let offset = alignment.offset(distance: <#T##CGFloat#>, radial: <#T##RadialDirection#>)
    return self[alignment]
    //    direction.offset(distance: distance, radial: radialDirection)
  }
}
