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
  public var unit: CGFloat

  public init(count: Int, unit: CGFloat) {
    self.count = count
    self.unit = unit
  }

  public init?(
    screenLength: CGFloat,
    unit: CGFloat,
    rounding: GridRounding = .down
  ) {
    guard let count = screenLength.toGridCount(using: unit, rounding: rounding) else {
      return nil
    }
    self.count = count
    self.unit = unit
  }
}

extension GridLength {

  public var gridLength: Int { count }
  public var screenLength: CGFloat { screenLength() }

  public func screenLength(fallback: CGFloat = 0) -> CGFloat {
    count.toScreenLength(using: unit) ?? fallback
  }

  public func clamped(min: Int, max: Int) -> Self {
    let newCount = self.count.clamped(min, max)
    return GridLength(count: newCount, unit: self.unit)
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
