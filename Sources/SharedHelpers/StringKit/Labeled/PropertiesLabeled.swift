//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled {
  associatedtype Value: StringConvertible

  var components: [LabelComponent<Value>] { get }
  var separators: Separators { get }
}

public struct LabelComponent<T: StringConvertible> {
  public let label: PropertyLabel
  public let value: T

  public init(
    _ label: PropertyLabel,
    value: T
  ) {
    self.label = label
    self.value = value
  }
}
