//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled {
//  associatedtype Value: StringConvertible

  var components: [LabelComponent] { get }
  var separators: Separators { get }
}

public struct LabelComponent {
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
