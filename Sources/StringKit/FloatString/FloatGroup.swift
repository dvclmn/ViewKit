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
    separators separatorVisibility: Separators.Visibility = .both
  ) -> String {

    //    let labels = components.enumerated().map { index, component in
    //      let labelString = component.label.stringValue(from: labelStyle) ?? ""
    //      let valueString = component.value.displayString(places: places, grouping: grouping)
    //      let isLast = index == components.count - 1
    //
    //      return labelString +
    //      separators.propertyLabelSeparator(from: self.separators) +
    //      valueString +
    //      separators.componentSeparator(from: self.separators, isLast: isLast)
    //    }
    //
    //    return labels.joined()

    let labels = components.map { component in

      let labelString = component.label.stringValue(from: labelStyle) ?? ""
      let valueString = component.value.displayString(places: places, grouping: grouping)

      /// Only include property label separator if that option is present
      let propertyLabelSeparator =
      separatorVisibility.contains(.propertyLabel)
      ? separators.propertyLabelSeparator
        : ""

      return labelString + propertyLabelSeparator + valueString
    }

    // Only include component separator if that option is present
    let componentSeparator =
    separatorVisibility.contains(.component)
      ? separators.componentSeparator
      : ""

    let joinedResult = labels.joined(separator: componentSeparator)
    return joinedResult

    //    let joinedResult: String
    //    if labelStyle.isNone {
    //      joinedResult = labels.joined("")
    //
    //    } else {
    //      joinedResult = labels.joined(separators.componentSeparator)
    //    }

    //    return joinedResult
  }

  //  private func sepString(
  //    for component: Component,
  //    separators: Separators.Visibility
  //  ) -> String {
  //    if separators.isEmpty {
  //  }
}
