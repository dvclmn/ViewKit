//
//  CGSize.swift
//  Collection
//
//  Created by Dave Coleman on 12/11/2024.
//

import SwiftUI
import GeometryPrimitives

extension CGSize: @retroactive Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(width)
    hasher.combine(height)
  }
}

extension CGSize {
  public init<T: BinaryFloatingPoint>(fromLength length: T) {
    self.init(width: CGFloat(length), height: CGFloat(length))
  }

  public init<T: BinaryFloatingPoint>(_ width: T, _ height: T) {
    self.init(width: CGFloat(width), height: CGFloat(height))
  }

}

extension CGSize {

  /// Euclidean magnitude of the vector?
  @available(
    *, deprecated, renamed: "magnitude",
    message: "Renamed to avoid confusion with Axis mapping methods, please use 'magnitude'"
  )
  public var length: CGFloat { sqrt(width * width + height * height) }
  public var magnitude: CGFloat { sqrt(width * width + height * height) }

  @available(
    *, deprecated, renamed: "normalisedMagnitude",
    message: "Renamed to avoid confusion with Axis mapping methods, please use 'normalisedMagnitude'"
  )
  public var normalisedLength: CGSize { length > 0 ? self / length : .zero }
  public var normalisedMagnitude: CGSize { magnitude > 0 ? self / magnitude : .zero }

  // MARK: - General

  public var longestDimension: CGFloat { max(width, height) }
  public var shortestDimension: CGFloat { min(width, height) }

  /// Returns the offset needed to centre a child of the given size within this container.
  /// Aka: The vector from container origin to child origin that equalises margins.
  /// Negative offsets indicate the child is larger than the container and will overflow equally on all sides.
  public func centeringOffset(forChild childSize: CGSize) -> CGSize {
    guard
      width.isFinite, height.isFinite,
      childSize.width.isFinite, childSize.height.isFinite
    else { return .zero }

    return CGSize(
      width: (width - childSize.width) / 2,
      height: (height - childSize.height) / 2
    )
  }

  /// Returns a new size reduced evenly on all four sides by the specified inset value,
  /// and clamped to min value of `0`.
  /// - Parameter inset: The amount to inset from all edges. Width and height are each reduced by 2x this value, 1x for each opposing side
  /// - Returns: A new CGSize with the inset applied
  public func inset(by inset: CGFloat) -> CGSize {
    return CGSize(
      width: max(0, width - (inset * 2)),
      height: max(0, height - (inset * 2))
    )
  }

  /// Returns a new size reduced by the specified edge insets,
  /// and clamped to a minimum value of `0` for each dimension.
  /// - Parameter insets: The per-edge insets to apply. Width is reduced by `left + right`, height by `top + bottom`.
  /// - Returns: A new CGSize with the insets applied
  public func inset(by insets: EdgeInsets) -> CGSize {
    let newWidth = max(0, width - (insets.leading + insets.trailing))
    let newHeight = max(0, height - (insets.top + insets.bottom))
    return CGSize(width: newWidth, height: newHeight)
  }
  
  public var diagonalLength: CGFloat {
    hypot(width, height)
  }

  public func clampBothDimensions(toMin length: CGFloat) -> CGSize {
    let width = max(length, width)
    let height = max(length, height)
    return CGSize(width: width, height: height)
  }

  /// Returns the centre point of the size
  public var midpoint: CGPoint {
    return CGPoint(x: width / 2, y: height / 2)
  }

  public var halved: CGSize {
    return CGSize(width: width / 2, height: height / 2)
  }

  

  public var hasValidValue: Bool {
    return !isNan && isFinite
  }

  /// Returns true if both dimensions are finite
  public var isFinite: Bool {
    width.isFinite && height.isFinite
  }

  /// Returns true if either dimension is NaN
  public var isNan: Bool {
    return width.isNaN || height.isNaN
  }

  //  public static func calculateMonospacedMetrics(for font: CTFont) -> CGSize {
  //    let spaceChar = " " as CFString
  //    var glyphRect = CGRect.zero
  //    let glyph = CTFontGetGlyphWithName(font, spaceChar)
  //    CTFontGetBoundingRectsForGlyphs(
  //      font,
  //      .horizontal,
  //      [glyph],
  //      &glyphRect,
  //      1
  //    )
  //
  //    let advance = CTFontGetAdvancesForGlyphs(font, .horizontal, [glyph], nil, 1)
  //    let lineHeight = CTFontGetAscent(font) + CTFontGetDescent(font)
  //
  //    return CGSize(width: CGFloat(advance), height: lineHeight)
  //  }

}
