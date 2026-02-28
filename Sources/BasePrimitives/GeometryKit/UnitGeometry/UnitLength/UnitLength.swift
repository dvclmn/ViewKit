//
//  Floateger.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

//import SwiftUI
import Foundation

/// Notes:
/// - `unit` means the original capture of View geometry (such as the
/// width and height of a font's glyph, at a certain size), which is then used
/// as the basis for conversion of a float, to an 'integer', or more of a coordinate
///
/// “This cell is 8 characters wide (grid-space),
/// which equals 8 × 9pt = 72pt (screen-space).”
public struct UnitLength: Hashable, Codable, Sendable {
  
  package var magnitude: Int
  public var unitLength: CGFloat
  
  public init(magnitude: Int, unitLength: CGFloat) {
    self.magnitude = magnitude
    self.unitLength = unitLength
  }
}

extension UnitLength {

  public init?(
    _ magnitude: Int,
    axis: GridAxis,
    mapping: AxisMapping = .default,
    unitSize: CGSize?
  ) {
    guard let unitSize else { return nil }
    let unitLength = unitSize.value(along: axis, mapping: mapping)
    self.magnitude = magnitude
    self.unitLength = unitLength
  }

  public init?(
    screenLength: CGFloat?,
    unitLength: CGFloat?,
    rounding: GridRounding = .down
  ) {
    guard let screenLength, let unitLength else { return nil }
    guard let count = screenLength.toGridCount(using: unitLength, rounding: rounding) else {
      return nil
    }
    self.magnitude = count
    self.unitLength = unitLength
  }
}
