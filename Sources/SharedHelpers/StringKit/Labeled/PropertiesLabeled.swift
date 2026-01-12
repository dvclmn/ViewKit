//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled {

  /// A component is a key+value pair, where the
  /// key is the property's text label ``PropertyLabel``,
  /// and the value is the floating point value of that property,
  /// conforming to ``StringConvertible``.
  ///
  /// E.g. `Width` paired with `10.5`
  ///
  /// Note: the ``PropertyLabel`` includes a trailing
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
  
  /// Default for convenience
  public var displayString: String { displayString() }
  
  /// In the moment / case-by-case properties, put into the
  /// function signature, for flexibility
  public func displayString(
    places: Int = 2,
    grouping: NumberGrouping = .automatic,
    labelStyle: PropertyLabel.Style = .standard,
    separators separatorVisibility: SeparatorVisibility = .both
  ) -> String {
    
    let labels = components.map { component in
      
      let labelString =
      component.label.stringValue(
        from: labelStyle,
        hasSeparator: separatorVisibility.contains(.propertyLabel)
      ) ?? ""
      let valueString: String = component.value.displayString(places: places, grouping: grouping)
      
      return labelString + valueString
    }
    
    /// Only include component separator if that option is present
    let separatorIfNeeded = separatorVisibility.contains(.component) ? separator : ""
    return labels.joined(separatorIfNeeded)
  }
  
}
