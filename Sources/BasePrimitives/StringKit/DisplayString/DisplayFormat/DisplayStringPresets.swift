//
//  DisplayStringPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

import Foundation

public enum FloatDisplayPreset: String, CaseIterable, Sendable {
  case standard
  case concise
  /// Display a floating point value with `0` decimal places
  case wholeNumber
  case showSign
  case percent

  public var format: FloatDisplayFormat {
    switch self {
      case .standard:
        .init()
      case .concise:
        .init(decimalPlaces: 0)
      case .wholeNumber:
        .init(decimalPlaces: 0)
      case .showSign:
        .init(sign: .always(renderPlusSign: false))
        
      case .percent:
        .init(decimalPlaces: 0)
    }
  }
}

