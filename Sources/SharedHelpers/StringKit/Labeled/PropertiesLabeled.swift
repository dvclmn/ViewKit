//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

/// Corresponds to older `FloatGroup`
public protocol PropertiesLabeled {
  associatedtype Value: StringConvertible
  
  var components: [LabelComponent<Value>] { get }
//  var components: [LabelComponent<Value>] { get }
  var separators: Separators { get }
}


//public protocol LabeledComponent {
////  associatedtype Value: StringConvertible
//  var label: PropertyLabel { get }
////  var value: Value { get }
//  var value: any StringConvertible { get }
//}
//
//public protocol FloatLabeledComponent: LabeledComponent {
//  var value: any FloatString { get }
//}

//public struct LabelComponent {
public struct LabelComponent<T: StringConvertible> {
  public let label: PropertyLabel
  public let value: T
//  public let value: any StringConvertible
  
  public init(
    _ label: PropertyLabel,
    value: T
//    value: any StringConvertible
  ) {
    self.label = label
    self.value = value
  }
}

//public struct FloatComponent: FloatLabeledComponent {
//  public let label: PropertyLabel
//  public let value: any FloatString
//}
