//
//  GridRect+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/3/2026.
//

import Foundation


extension CGRect {
  public init(
    fromGridRect gridRect: GridRect,
    using unitSize: CGSize,
    mapping: AxisMapping = .default,
  ) {
    self = GridScreenConversion.screenRect(
      for: gridRect,
      unitSize: unitSize,
      mapping: mapping,
    )
  }
}
