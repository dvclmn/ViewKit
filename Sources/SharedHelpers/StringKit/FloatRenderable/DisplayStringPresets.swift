//
//  DisplayStringPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

import Foundation

public enum DisplayStringPreset: String, CaseIterable {
  case standard
  case concise
  case percent
  case showSign
  
}
extension FloatRenderable {
  
  
  /// A convenience that just returns the `displayString()`
  /// method with it's default values
  public var displayString: String { self.render() }
  
//  public var displayStringConcise: String { self.render(using: .short) }
  
//  public var displayStringWithSign: String {
//    let format = DisplayFormat(
//      decimalPlaces: 2,
//      sign: .always(renderPlusSign: false)
//    )
//    return self.render(using: format)
//  }
  
  /// Going to prefer `render(using:)` for customisation
  /// For backwards compat
//  public func displayString(
//    places: Int = 2,
//    grouping: NumberGrouping = .automatic
//  ) -> String {
//    render(
//      using: DisplayFormat(
//        decimalPlaces: places,
//        grouping: grouping,
//      )
//    )
//  }
}
