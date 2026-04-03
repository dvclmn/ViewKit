//
//  Grid+ScreenConversion.swift
//  BaseHelpers
//
//  Created by Codex on 22/3/2026.
//

import CoreGraphics
import InteractionKit

/// Centralised Grid ⇄ Screen conversions that respect `AxisMapping`.
///
/// Keep the core maths here, and have higher-level helpers delegate to these
/// to avoid row/column mix-ups.
public enum GridScreenConversion {

  public static func screenPoint(
    for position: GridPosition,
    unitSize: CGSize,
    mapping: AxisMapping = .default
  ) -> CGPoint {
    let h = position.value(along: .horizontal, mapping: mapping)
    let v = position.value(along: .vertical, mapping: mapping)

    let x = h.toScreenLength(along: .horizontal, mapping: mapping, using: unitSize)
    let y = v.toScreenLength(along: .vertical, mapping: mapping, using: unitSize)

    return CGPoint(x: x, y: y)
  }

  public static func screenSize(
    for dimensions: GridDimensions,
    unitSize: CGSize,
    mapping: AxisMapping = .default
  ) -> CGSize {
    let h = dimensions.value(along: .horizontal, mapping: mapping)
    let v = dimensions.value(along: .vertical, mapping: mapping)

    let width = h.toScreenLength(along: .horizontal, mapping: mapping, using: unitSize)
    let height = v.toScreenLength(along: .vertical, mapping: mapping, using: unitSize)

    return CGSize(width: width, height: height)
  }

  public static func screenRect(
    for rect: GridRect,
    unitSize: CGSize,
    mapping: AxisMapping = .default
  ) -> CGRect {
    CGRect(
      origin: screenPoint(for: rect.origin, unitSize: unitSize, mapping: mapping),
      size: screenSize(for: rect.size, unitSize: unitSize, mapping: mapping)
    )
  }
}

extension GridRect {

  public func toScreenRect(
    using unitSize: CGSize,
    mapping: AxisMapping = .default
  ) -> CGRect {
    GridScreenConversion.screenRect(for: self, unitSize: unitSize, mapping: mapping)
  }
}
