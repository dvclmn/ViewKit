//
//  PropertiesLabeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled {
  associatedtype Component: LabeledComponent
  
  //public protocol LabeledGroup {
  var components: [Component] { get }
  var separators: Separators { get }
}

/// Types like `CGPoint` that have float properties.
/// May be a pair, like `CGPoint`'s `x` and `y`,
/// or more, like `CGRect`

public protocol FloatGroup: PropertiesLabeled where Component == FloatComponent {
  func displayString(
    places: Int,
    grouping: Grouping,
    labelStyle: PropertyLabel.Style,
    separators: Separators.Visibility
  ) -> String
}
