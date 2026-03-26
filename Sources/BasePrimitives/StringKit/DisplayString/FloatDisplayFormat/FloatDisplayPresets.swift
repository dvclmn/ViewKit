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
  case wholeNumber // No decimal places
  case showSign

  public var format: FloatDisplayFormat {
    switch self {
      case .standard: .init()
      case .concise: .init(decimalPlaces: 0)
      case .wholeNumber: .init(decimalPlaces: 0)
      case .showSign: .init(sign: .always(renderPlusSign: false))
    }
  }
}
