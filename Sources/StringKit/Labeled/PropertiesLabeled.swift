//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

/// Corresponds to older `FloatGroup`
public protocol PropertiesLabeled {
  associatedtype Component: LabeledComponent
  
  var components: [Component] { get }
  var separators: Separators { get }
}

public protocol LabeledComponent {
//  associatedtype Value: StringConvertible
  var label: PropertyLabel { get }
//  var value: Value { get }
  var value: any StringConvertible { get }
}

public protocol FloatLabeledComponent: LabeledComponent {
  var value: any FloatString { get }
}

public struct LabelComponent: LabeledComponent {
  public let label: PropertyLabel
  public let value: any StringConvertible
  
  public init(
    _ label: PropertyLabel,
    value: any StringConvertible
  ) {
    self.label = label
    self.value = value
  }
}

//public struct FloatComponent<T: FloatString>: LabeledComponent {
//  public let label: PropertyLabel
//  public let value: T
//}
