//
//  DisplayStringPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

import Foundation

public enum FloatDisplayPreset: String, CaseIterable {
  case standard

  case concise

  /// Display a floating point value with `0` decimal places
  case wholeNumber
  case showSign
  
  case dimensions

  public var format: FloatDisplayFormat {
    switch self {
      case .standard:
        .init()

      case .concise:
        .init(
          decimalPlaces: 0,
          labelStyle: .abbreviated,
          separators: .component
        )

      case .wholeNumber:
        .init(decimalPlaces: 0)
        
      case .dimensions:
          .init(
            decimalPlaces: 0,
            labelStyle: .abbreviated,
            separators: .component
          )

      case .showSign:
        .init(
          sign: .always(renderPlusSign: false)
        )
    }
  }
}

extension FloatDisplayPreset {
  //  public init(from format: FloatDisplayFormat) {
  //    // Attempt to infer a preset from the provided format by matching
  //    // the same knobs we use when constructing presets above.
  //    // If no exact match is found, fall back to `.standard`.
  //
  //    // Default
  //    self = .standard
  //
  //    // Helper closures to safely compare without relying on all properties existing
  //    let decimalPlaces = format.decimalPlaces
  //    let labelStyle = format.labelStyle
  //    let separatorVisibility = format.separatorVisibility
  //    let sign = format.sign
  //
  //    // Match: concise
  //    // concise: decimalPlaces: 0, labelStyle: .abbreviated, separatorVisibility: .component
  //    if decimalPlaces == 0,
  //       labelStyle == .abbreviated,
  //       separatorVisibility == .component {
  //      self = .concise
  //      return
  //    }
  //
  //    // Match: wholeNumber
  //    // wholeNumber: decimalPlaces: 0
  //    if decimalPlaces == 0 {
  //      self = .wholeNumber
  //      return
  //    }
  //
  //    // Match: showSign
  //    // showSign: sign == .always(renderPlusSign: false)
  //    if sign == .always(renderPlusSign: false) {
  //      self = .showSign
  //      return
  //    }
  //
  //    // Fallback remains `.standard`
  //  }
}

//extension FloatRenderable {
//
//}

//extension PropertiesLabeled {

/// Default for convenience
//  public var displayString: String { displayString() }
//
//  /// In the moment / case-by-case properties, put into the
//  /// function signature, for flexibility
//  public func displayString(
//    places: Int = 2,
//    grouping: NumberGrouping = .automatic,
//    labelStyle: PropertyLabel.Style = .standard,
//    separators separatorVisibility: SeparatorVisibility = .both
//  ) -> String {
//    render(
//      using: DisplayFormat(
//        decimalPlaces: places,
//        grouping: grouping,
//        labelStyle: labelStyle,
//        separatorVisibility: separatorVisibility
//      )
//    )
//  }
//}
