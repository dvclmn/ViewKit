//
//  DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/7/2025.
//

import SwiftUI

public typealias NumberGrouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

public protocol FloatRenderable: StringRenderable {
  associatedtype Value: BinaryFloatingPoint
  var value: Value { get }
  func render(using format: DisplayFormat) -> String
}

/// This doesn't concern itself with things like
/// property labels (e.g. "W" for width etc).
/// Just formatting a single value, and returning it for
/// any further processing required
extension FloatRenderable {

  public func render(using format: DisplayFormat = .default) -> String {
    let toFormat = Double(value)
//    let intLength: Range<Int>
//
//    if let integerLength = format.integerLength {
//      intLength = integerLength..<integerLength
//    } else {
//      intLength = 1..<Int.max
//    }

    return toFormat.formatted(
      .number
        .precision(
          //          .integerAndFractionLength(
          //            integerLimits: Ra,
          //            fractionLimits:
          //          )

          //          .fractionLength(format.decimalPlaces)

          .integerAndFractionLength(
            integer: format.integerLength ?? 0,
            fraction: format.decimalPlaces
          )
          //          .integerAndFractionLength(
          //            integerLimits: intLength,
          //            fractionLimits: format.decimalPlaces
          //          )
        )

        .grouping(format.grouping)
    )
  }

  /// `StringRenderable` conformance
  public var toString: String { self.render() }

  /// A convenience that just returns the `displayString()`
  /// method with it's default values
  public var displayString: String { self.render() }

  /// For backwards compat
  public func displayString(
    places: Int = 2,
    grouping: NumberGrouping = .automatic
  ) -> String {
    render(
      using: DisplayFormat(
        decimalPlaces: places,
        grouping: grouping,
      )
    )
  }
}
// MARK: - Conformances
extension Double: FloatRenderable {
  public var value: Self { self }
}
extension CGFloat: FloatRenderable {
  public var value: Self { self }
}

extension BinaryFloatingPoint {
  public func toPercentString(within range: ClosedRange<Self>) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.displayString(places: 0) + "%")
  }
}
