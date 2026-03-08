//
//  FloatGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

public struct Separators: Sendable, Equatable {
  let label: Separator
  let property: Separator
  let component: ComponentDelimiter

  public init(
    label: Separator = .colon,
    property: Separator = .colon,
    component: ComponentDelimiter = .space
  ) {
    self.label = label
    self.property = property
    self.component = component
  }
}

extension Separators {
  public subscript(kind kind: SeparatorKind) -> String? {
    switch kind {
      case .label: label.toString
      case .propertyLabel: property.toString
      case .componentDelimiter: component.toString
    }
  }
  public static let `default`: Self = .init()
}

//import Foundation
//
///// Coordinating all separators in this domain:
/////
///// Which types have separators?
///// - ``PropertiesLabeled``
///// - ``PropertyLabel``
///// - ``Labeled``
//
///// Trying to achieve `120 x 260`
///// This looks like a
//
///// A component is a key+value pair, where the
///// key is the property's text label ``PropertyLabel``,
///// and the value is the floating point value of this property
//public struct LabelComponent {
//
//  /// E.g. `Width`, or `X`. May include a separator,
//  /// such as the colon here in `Height:`
//  public let label: PropertyLabel
//
//  /// The value corresponding to the label
//  public let value: any FloatRenderable
//
//  public init(
//    _ label: PropertyLabel,
//    value: any FloatRenderable
//  ) {
//    self.label = label
//    self.value = value
//  }
//}
//
//extension LabelComponent {
//  func stringValue(using format: FloatDisplayFormat) -> String {
//    let labelText = label.stringValue(using: format)
//    let valueText = value.render(using: format)
//    return labelText.map { $0 + valueText } ?? valueText
//  }
//}
