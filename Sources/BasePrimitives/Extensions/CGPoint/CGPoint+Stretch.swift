//
//  CGPoint+Stretched.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

// MARK: - Stretch out an Axis
public struct StretchOptions: OptionSet, Sendable {
  public let rawValue: Int
  static let normalised = StretchOptions(rawValue: 1 << 0)
  public static let clamped = StretchOptions(rawValue: 1 << 0)

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}
extension CGPoint {

  /// Map cursorX to a stretched range
  ///
  /// The utility of this may not be obvious at first glance, so here's a simple example.
  /// For my `.hover3DEffect()` modifier, I wanted the range of movement
  /// (along the x axis) for the 'glint' effect, to be *wider* than the pointer's actual
  /// range, across the surface of the view. This maps an axis of a CGPoint to be wider
  /// (or narrower) than the original.
  public func stretchedPosition(
    _ axis: Axis,
    in size: CGSize,
    stretchFactor: CGFloat,
    options: StretchOptions = []
  ) -> CGFloat {

    let rawLocation: CGFloat =
      switch axis {
        case .horizontal: self.x
        case .vertical: self.y
      }

    let viewLength: CGFloat =
      switch axis {
        case .horizontal: size.width
        case .vertical: size.height
      }

    let normalisedValue =
      options.contains(.normalised) ? rawLocation / viewLength : rawLocation

    let centered: CGFloat
    let result: CGFloat

    if options.contains(.normalised) {
      centered = normalisedValue - 0.5
      result = centered * stretchFactor + 0.5
    } else {
      centered = rawLocation - (viewLength / 2)
      result = centered * stretchFactor + (viewLength / 2)
    }

    if options.contains(.clamped) {
      return result.clamped(to: 0...1)
    }

    return result
  }

  /// Hint: use extension `toCGRect` on `CGSize` for convenient
  /// conversion, if origin is `zero`.
  public func mapped(to destination: CGRect) -> CGPoint {
    let result = CGPoint(
      x: destination.origin.x + (self.x * destination.width),
      y: destination.origin.y + (self.y * destination.height)
    )
    return result
  }

  public func remapped(from oldRect: CGRect, to newRect: CGRect) -> CGPoint {
    let normalisedX = (self.x - oldRect.minX) / oldRect.width
    let normalisedY = (self.y - oldRect.minY) / oldRect.height

    let newX = newRect.minX + (normalisedX * newRect.width)
    let newY = newRect.minY + (normalisedY * newRect.height)

    return CGPoint(x: newX, y: newY)
  }

}
