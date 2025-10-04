//
//  FloatGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// Types like `CGPoint` that have floats as it's properties
public protocol FloatGroup {
  var components: [Component] { get }
  var separators: Separators { get }
}

/// Can be a pair (like CGPoint), or three (like CGRect) etc
extension FloatGroup {

  /// In the moment / case-by-case properties, put into the
  /// function signature, for flexibility
  func output(
    places: Int,
    grouping: Grouping,
    labelStyle: PropertyLabel.Style = .standard,
  ) -> String {
    let labels = components.map { component in
      let labelString = component.label.stringValue(from: labelStyle) ?? ""
      let valueString = component.value.displayString(places, grouping: grouping)
      return labelString + separators.propertyLabel + valueString
    }
    return labels.joined(separators.component)
  }
}
