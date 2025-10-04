//
//  Model+DisplayConformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/7/2025.
//

import SwiftUI

/// Primitive conformances
extension Double: FloatDisplay {
  public var value: Self { self }
}
extension CGFloat: FloatDisplay {
  public var value: Self { self }
}

//extension CGPoint {
//  public func displayString(
//    _ places: DecimalPlaces = .fractionLength(2),
//    grouping: Grouping = .automatic,
//    labelStyle: PropertyLabel.Style = .standard
//  ) -> String {
//    DisplayString(separator: ", ") {
//      Labeled("X", value: self.x)
//      Labeled("Y", value: self.y)
//    }
//    .formatted(
//      places,
//      grouping: grouping,
//      labelStyle: labelStyle
//    )
//  }
//}

//// Keep FloatDisplay for common cases
