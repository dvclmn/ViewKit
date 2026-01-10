//
//  CGSize.swift
//  Collection
//
//  Created by Dave Coleman on 12/11/2024.
//

import SwiftUI

extension CGSize: @retroactive Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(width)
    hasher.combine(height)
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

  // MARK: - Initialisers

  public init(fromLength length: CGFloat) {
    self.init(width: length, height: length)
  }

  public init(_ width: CGFloat, _ height: CGFloat) {
    self.init(width: width, height: height)
  }

  // MARK: - Conversions

  public var toCGRectZeroOrigin: CGRect {
    CGRect(origin: .zero, size: self)
  }

  public var toCGPoint: CGPoint {
    CGPoint(x: width, y: height)
  }

  // MARK: - General

  public var longestDimension: CGFloat {
    return max(width, height)
  }
  public var shortestDimension: CGFloat {
    return min(width, height)
  }

  public func point(for unitPoint: UnitPoint) -> CGPoint {
    unitPoint.toCGPoint(in: self)
  }

  /// Returns the offset needed to centre a child of the given size within this container.
  public func centeringOffset(forChild childSize: CGSize) -> CGSize {
    return CGSize(
      width: (self.width - childSize.width) / 2,
      height: (self.height - childSize.height) / 2
    )
  }

  /// Returns a new size reduced evenly on all four sides by the specified inset value, and clamped to min value of `0`.
  /// - Parameter inset: The amount to inset from all edges. Width and height are each reduced by 2x this value, 1x for each opposing side
  /// - Returns: A new CGSize with the inset applied
  public func inset(by inset: CGFloat) -> CGSize {
    return CGSize(
      width: max(0, width - (inset * 2)),
      height: max(0, height - (inset * 2))
    )
  }

  public func clampBothDimensions(toMin length: CGFloat) -> CGSize {
    let width = self.width.clamped(length)
    let height = self.height.clamped(length)
    return CGSize(width: width, height: height)
  }

  /// Returns the centre point of the size
  public var midpoint: CGPoint {
    return CGPoint(x: width / 2, y: height / 2)
  }

  public var halved: CGSize {
    return CGSize(width: width / 2, height: height / 2)
  }

  public func aspectRatio(
    mode: ResizeMode,
    intoSize size: CGSize
  ) -> CGSize {
    if self == .zero {
      return self
    }
    let widthRatio = size.width / self.width
    let heightRatio = size.height / self.height

    /// Handle stretch mode separately since it doesn't preserve aspect ratio
    if mode == .stretch {
      return size
    }

    let ratio: CGFloat =
      switch mode {
        case .fit: min(widthRatio, heightRatio)
        case .fill: max(widthRatio, heightRatio)
        case .stretch: 1.0
      }

    return CGSize(
      width: self.width * ratio,
      height: self.height * ratio
    )
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
