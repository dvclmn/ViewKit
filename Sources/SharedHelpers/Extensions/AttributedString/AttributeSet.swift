//
//  Attributes.swift
//  TextCore
//
//  Created by Dave Coleman on 30/8/2024.
//

import SwiftUI

public typealias TextAttributes = [NSAttributedString.Key: Any]
//public typealias TextAttributes = [NSAttributedString.Key: Any]

public typealias FontAttributes = NSFontDescriptor.AttributeName
public typealias TraitKey = NSFontDescriptor.TraitKey

public struct AttributeSet: ExpressibleByDictionaryLiteral {

  public var attributes: TextAttributes

  public init(dictionaryLiteral elements: (TextAttributes.Key, TextAttributes.Value)...) {
    self.attributes = Dictionary(uniqueKeysWithValues: elements)
  }

  public init(_ attributes: TextAttributes) {
    self.attributes = attributes
  }

  public init(
    font: Font,
    foreground: Color = .primary,
    background: Color = .clear,
    additionalAttributes: TextAttributes = [:]
  ) {
    let baseAttributes: TextAttributes = [
      .font: font,
      .foregroundColor: foreground,
      .backgroundColor: background,
    ]
    self.attributes = baseAttributes.merging(additionalAttributes) { (_, new) in new }
  }

  //  public init(
  //    font: NSUIFont,
  //    foreground: NSUIColor = .label,
  //    background: NSUIColor = .clear,
  //    additionalAttributes: Attributes = [:]
  //  ) {
  //    let baseAttributes: Attributes = [
  //      .font: font,
  //      .foregroundColor: foreground,
  //      .backgroundColor: background,
  //    ]
  //    self.attributes = baseAttributes.merging(additionalAttributes) { (_, new) in new }
  //  }

  public subscript(_ key: TextAttributes.Key) -> Any? {
    get { attributes[key] }
    set { attributes[key] = newValue }
  }

  public func merging(with other: AttributeSet) -> AttributeSet {
    AttributeSet(attributes.merging(other.attributes) { (_, new) in new })
  }

  /// Add method to convert to AttributeContainer for SwiftUI
  //  public func toAttributeContainer() -> AttributeContainer {
  //    var container = AttributeContainer()
  //    for (key, value) in attributes {
  //      container[AttributeScopes.SwiftUIAttributes] = value
  //    }
  //    return container
  //  }
}

extension AttributeSet: Sequence {
  public func makeIterator() -> Dictionary<NSAttributedString.Key, Any>.Iterator {
    return attributes.makeIterator()
  }
}
