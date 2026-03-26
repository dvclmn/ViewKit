//
//  FloatRender+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/3/2026.
//

import Foundation

extension FloatRenderable {
  public func render(using format: FloatDisplayFormat = .default) -> String {

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

  private func renderWithoutIntegerLength(format: FloatDisplayFormat) -> String {
    Double(self).formatted(
      .number
        .precision(.fractionLength(format.decimalPlaces))
        .grouping(format.grouping)
        .sign(strategy: format.sign.toNativeStrategy)
    )
  }

  private func renderWithIntegerLength(
    _ integerLength: Int,
    format: FloatDisplayFormat
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
