//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol LabeledComponent {
  associatedtype Value: StringConvertible
  var label: PropertyLabel { get }
  var value: Value { get }
}

public struct LabelComponent<T: StringConvertible>: LabeledComponent {
  public let label: PropertyLabel
  public let value: T
}

public struct FloatComponent<T: FloatString>: LabeledComponent {
  public let label: PropertyLabel
  public let value: T
}
