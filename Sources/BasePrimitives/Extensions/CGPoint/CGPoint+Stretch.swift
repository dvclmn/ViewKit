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

  public func mapPoint(
    from source: CGRect,
    to destination: CGRect,
    mode: ContentSizeMode = .fit
  ) -> CGPoint {
    switch mode {
      case .stretch: stretchMap(from: source, to: destination)
      case .fit: aspectFitMap(from: source, to: destination)
      case .fill: aspectFillMap(from: source, to: destination)
      case .fixed: fatalError("Not yet supported")
    }
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

  private func aspectFitMap(from source: CGRect, to destination: CGRect) -> CGPoint {
    let fittedRect = aspectMappedRect(from: source, to: destination, fill: false)
    return stretchMap(from: source, to: fittedRect)
  }

  private func aspectFillMap(from source: CGRect, to destination: CGRect) -> CGPoint {
    let filledRect = aspectMappedRect(from: source, to: destination, fill: true)
    return stretchMap(from: source, to: filledRect)
  }

  private func aspectMappedRect(
    from source: CGRect,
    to destination: CGRect,
    fill: Bool
  ) -> CGRect {
    let sourceAspect = source.width / source.height
    let destAspect = destination.width / destination.height

    var scale: CGFloat
    var size: CGSize
    var origin: CGPoint

    if (fill && sourceAspect < destAspect) || (!fill && sourceAspect > destAspect) {
      // Width-constrained
      scale = destination.width / source.width
      size = CGSize(width: destination.width, height: source.height * scale)
      origin = CGPoint(
        x: destination.minX,
        y: destination.minY + (destination.height - size.height) / 2
      )
    } else {
      // Height-constrained
      scale = destination.height / source.height
      size = CGSize(width: source.width * scale, height: destination.height)
      origin = CGPoint(
        x: destination.minX + (destination.width - size.width) / 2,
        y: destination.minY
      )
    }

    return CGRect(origin: origin, size: size)
  }

  private func stretchMap(from source: CGRect, to destination: CGRect) -> CGPoint {
    let scaleX = destination.width / source.width
    let scaleY = destination.height / source.height

    let translatedX = (self.x - source.minX) * scaleX + destination.minX
    let translatedY = (self.y - source.minY) * scaleY + destination.minY

    return CGPoint(x: translatedX, y: translatedY)
  }

}
