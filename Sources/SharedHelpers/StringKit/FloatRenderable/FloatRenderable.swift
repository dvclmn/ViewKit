//
//  DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/7/2025.
//

import SwiftUI

public typealias NumberGrouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

public protocol FloatRenderable: BinaryFloatingPoint & Sendable {
  func render(using format: DisplayFormat) -> String
}

extension Double: FloatRenderable {}
extension CGFloat: FloatRenderable {}
extension Float: FloatRenderable {}

extension FloatRenderable {
  public func render(using format: DisplayFormat = .default) -> String {

    let result: String
    if let integerLength = format.integerLength {
      result = renderWithIntegerLength(integerLength, format: format)
    } else {
      result = renderWithoutIntegerLength(format: format)
    }

    return format.sign.shouldPostProcess
      ? format.sign.processingLeadingPlus(in: result)
      : result
  }

  private func renderWithoutIntegerLength(format: DisplayFormat) -> String {
    Double(self).formatted(
      .number
        .precision(.fractionLength(format.decimalPlaces))
        .grouping(format.grouping)
        .sign(strategy: format.sign.toNativeStrategy)
    )
  }

  private func renderWithIntegerLength(
    _ integerLength: Int,
    format: DisplayFormat
  ) -> String {
    Double(self).formatted(
      .number
        .precision(
          .integerAndFractionLength(
            integer: integerLength,
            fraction: format.decimalPlaces
          )
        )
        .grouping(format.grouping)
    )
  }

}

extension BinaryFloatingPoint {
  public func toPercentString(within range: ClosedRange<Self>) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.displayString(places: 0) + "%")
  }
}
