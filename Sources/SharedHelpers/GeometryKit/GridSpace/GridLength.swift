//
//  Floateger.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

import SwiftUI

/// Notes:
/// - `unit` means the original capture of View geometry (such as the
/// width and height of a font's glyph, at a certain size), which is then used
/// as the basis for conversion of a float, to an 'integer', or more of a coordinate
///
/// “This cell is 8 characters wide (grid-space),
/// which equals 8 × 9pt = 72pt (screen-space).”
///
/// Settled on the names now, which is Grid length, and Screen length
public struct GridLength: Hashable, Codable {

  /// Prefer use of ``gridLength``, to better pair with ``screenLength``
  private var count: Int
  public var unitLength: CGFloat

  public init(count: Int, unitLength: CGFloat) {
    self.count = count
    self.unitLength = unitLength
  }

  public init?(
    _ count: Int,
    axis: Axis,
    convention: AxisConvention = .default,
    unitSize: CGSize?
  ) {
    guard let unitSize else { return nil }
    let unitLength = unitSize.length(along: axis.toAxis2D, convention: convention)
    self.count = count
    self.unitLength = unitLength
  }

  public init?(
    screenLength: CGFloat?,
    unit: CGFloat?,
    rounding: GridRounding = .down
  ) {
    guard let screenLength, let unit else { return nil }
    guard let count = screenLength.toGridCount(using: unit, rounding: rounding) else {
      return nil
    }
    self.count = count
    self.unitLength = unit
  }
}

extension GridLength {

  public var gridLength: Int { count }
  public var screenLength: CGFloat { screenLength() }

  public func screenLength(fallback: CGFloat = 0) -> CGFloat {
    count.toScreenLength(using: unitLength) ?? fallback
  }

  public func clamped(min: Int, max: Int) -> Self {
    let newCount = self.count.clamped(min, max)
    return GridLength(count: newCount, unitLength: self.unitLength)
  }
}

extension GridLength: Comparable {
  public static func < (
    lhs: GridLength,
    rhs: GridLength
  ) -> Bool {
    lhs.count < rhs.count
  }
}
