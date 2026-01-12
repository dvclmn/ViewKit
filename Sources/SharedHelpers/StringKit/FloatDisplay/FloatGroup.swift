//
//  FloatGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// Types like `CGPoint` that have float properties.
/// May be a pair, like `CGPoint`'s `x` and `y`,
/// or more, like `CGRect`
extension PropertiesLabeled {

  /// Default for convenience
  public var displayString: String { displayString() }

  /// In the moment / case-by-case properties, put into the
  /// function signature, for flexibility
  public func displayString(
    places: Int = 2,
    grouping: NumberGrouping = .automatic,
    labelStyle: PropertyLabel.Style = .standard,
    separators separatorVisibility: Separators.Visibility = .both
  ) -> String {

    let labels = components.map { component in

      let labelString = component.label.stringValue(from: labelStyle) ?? ""
      let valueString = component.value.displayString(places: places, grouping: grouping)

      /// Only include property label separator if that option is present
      let hasSeparator =
        separatorVisibility.contains(.propertyLabel)
        && !labelStyle.isNone
      let propertyLabelSeparator = hasSeparator ? separators.propertyLabelSeparator : ""

      return labelString + propertyLabelSeparator + valueString
    }

    /// Only include component separator if that option is present
    let hasSeparator =
      separatorVisibility.contains(.component)
    let componentSeparator = hasSeparator ? separators.componentSeparator : ""

    let joinedResult = labels.joined(separator: componentSeparator)
    return joinedResult
  }

}
