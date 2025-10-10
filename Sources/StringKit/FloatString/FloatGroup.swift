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
public protocol FloatGroup {
  var components: [Component] { get }
  var separators: Separators { get }

  func displayString(
    places: Int,
    grouping: Grouping,
    labelStyle: PropertyLabel.Style,
    separators: Separators.Visibility
  ) -> String
}

extension FloatGroup {

  /// Default for convenience
  public var displayString: String { displayString() }

  /// In the moment / case-by-case properties, put into the
  /// function signature, for flexibility
  public func displayString(
    places: Int = 2,
    grouping: Grouping = .automatic,
    labelStyle: PropertyLabel.Style = .standard,
    separators: Separators.Visibility = .both
  ) -> String {
    
    let labels = components.map { component in
      ///
      let labelString = component.label.stringValue(from: labelStyle) ?? ""
      let valueString = component.value.displayString(places: places, grouping: grouping)
      
      return labelString + separators.propertyLabelSeparator + valueString
    }
    
    let joinedResult: String
    if labelStyle.isNone {
      joinedResult = labels.joined("")
      
    } else {
      joinedResult = labels.joined(separators.componentSeparator)
    }

    return joinedResult
  }
}
