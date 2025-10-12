//
//  DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/7/2025.
//

import SwiftUI

public enum FloatDisplay {}

public typealias Grouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

extension FloatDisplay {
  public protocol FloatString: StringConvertible {
    associatedtype Value: BinaryFloatingPoint
    var value: Value { get }
    
    /// This is an early formatting pass, just to get the
    /// decimal places and other numeric/float based
    /// formatting sorted, before other touches.
    func displayString(
      places: Int,
      grouping: Grouping
    ) -> String
  }
}

/// This doesn't concern itself with things like
/// property labels (e.g. "W" for width etc).
/// Just formatting a single value, and returning it for
/// any further processing required
extension FloatDisplay.FloatString {

  /// `StringConvertible` conformance
  public var toString: String { self.displayString() }

  /// A convenience that just returns the `displayString()`
  /// method with it's default values
  public var displayString: String { self.displayString() }

  public func displayString(
    places: Int = 2,
    grouping: Grouping = .automatic
  ) -> String {

    /// Manually converting from the more ambiguous `BinaryFloatingPoint`,
    /// to `Double`, so the compiler knows exactly what we're dealing with
    let valueToFormat = Double(value)

    let formatted = valueToFormat.formatted(
      .number.precision(.fractionLength(places))
        .grouping(grouping)
    )

    return formatted
  }

}
// MARK: - Conformances
extension Double: FloatDisplay.FloatString {
  public var value: Self { self }
}
extension CGFloat: FloatDisplay.FloatString {
  public var value: Self { self }
}
