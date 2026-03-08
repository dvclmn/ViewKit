//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

public struct Labeled: Sendable {

  public let key: String

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  public let separator: String
  public let value: DisplayFragment?
  public let formatOverride: FloatDisplayFormat?  // nil = inherit from DisplayString

  public init(_ key: String, value: Any?, separator: String = ": ") {
    self.key = key
    self.separator = separator
    self.value = value.map { DisplayFragment.make(from: $0) }
    self.formatOverride = nil
  }

  public var block: DisplayBlock {
    .labeled(key: key, separator: separator, value: value)
  }

  public static func toString(
    key: String,
    value: DisplayFragment?,
    separator: String,
    using format: FloatDisplayFormat
  ) -> String {
    let valueText = value?.render(using: format) ?? "nil"
    return key + separator + valueText
  }

  //  public init(
  //    _ key: String,
  //    value: Any?,
  //    separator: String = ": "
  //  ) {
  //    self.key = key
  //    self.value = value as? (any StringRenderable)
  //    //    self.value = DisplayBlock(from: value)
  //    //    self.value = DisplayBlock.semantic(for: value)
  //    self.separator = separator
  //  }
}

extension Labeled {

  private init(
    key: String,
    value: Any?,
    separator: String,
    formatOverride: FloatDisplayFormat?
  ) {
    self.key = key
    self.separator = separator
    self.value = value.map { DisplayFragment.make(from: $0) }
    self.formatOverride = formatOverride
  }

  public func labelStyle(_ style: PropertyLabel.Style) -> Labeled {
    var format = formatOverride ?? .default
    format.labelStyle = style
    return Labeled(
      key: key,
      value: value,
      separator: separator,
      formatOverride: format
    )
  }
}
