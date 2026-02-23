//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled: DisplayRenderable {

  /// E.g. `Width` paired with `10.5`
  ///
  /// Note: ``LabelComponent`` holds onto a ``PropertyLabel``,
  /// which 
  /// the ``PropertyLabel`` includes a trailing
  /// separator, delimiting the Label and Value. This is different
  /// to the below ``PropertiesLabeled/separator``.
  var components: [LabelComponent] { get }

  /// Text separating each Label+Value pairing.
  /// E.g. the comma `,` in `X: 10, Y: -20`
  var separator: String { get }
}

/// Types like `CGPoint` that have float properties.
/// May be a pair, like `CGPoint`'s `x` and `y`,
/// or more, like `CGRect`
extension PropertiesLabeled {

  public func render(using format: DisplayFormat) -> String {
    let sepVis = format.separatorVisibility
    let labels = components.map { component in

      let labelString =
        component.label.stringValue(
          from: format.labelStyle,
          hasSeparator: sepVis.contains(.propertyLabel)
        ) ?? ""

      let valueString: String = component.value.render(using: format)

      return labelString + valueString
    }

    /// Only include component separator if that option is present
    let separatorIfNeeded = sepVis.contains(.component) ? separator : ""
    return labels.joined(separatorIfNeeded)
  }

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
