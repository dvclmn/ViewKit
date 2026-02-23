//
//  DisplayStringPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

import Foundation


extension FloatRenderable {
  /// A convenience that just returns the `displayString()`
  /// method with it's default values
  public var displayString: String { self.render() }
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    render(using: preset.format)
  }
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

extension PropertiesLabeled {

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
}
