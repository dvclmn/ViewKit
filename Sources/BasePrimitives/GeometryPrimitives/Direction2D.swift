//
//  Direction2D.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI
import InteractionKit

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
    axis: GeometryAxis,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGFloat {
    let offset = offset(distance: distance, radial: radialDirection)
    return axis.isHorizontal ? offset.width : offset.height
  }

  /// Consider similarities (possibly merging etc), based on extension
  /// `CGPoint/repositioned(to:in:)`
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
    axis: GeometryAxis,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward
  ) -> CGFloat {
    direction.offset(axis: axis, distance: distance, radial: radialDirection)
  }

}

extension ViewDimensions {
  public func offset(
    for alignment: Alignment,
    axis: GeometryAxis,
    magnitude: CGFloat,  // As a factor, e.g. 0.2
    radial radialDirection: RadialDirection = .outward
  ) -> CGFloat {

    let viewLength = axis.isHorizontal ? self.width : self.height
    let offsetAmount: CGFloat = viewLength * magnitude
    let targetAlignment = getAlignment(alignment)
    let offset = targetAlignment.offset(
      axis: axis,
      distance: offsetAmount,
      radial: radialDirection
    )
    return axis.isHorizontal
      ? self[targetAlignment.horizontal] + offset
      : self[targetAlignment.vertical] + offset

  }

  private func getAlignment(
    _ alignment: Alignment,
  ) -> Alignment {
    //    let excluded: [Alignment] = [.center]
    let toFlip: [Alignment] = [.leading, .trailing, .top, .bottom]
    return toFlip.contains(alignment) ? alignment.toOpposing : alignment
  }
}
