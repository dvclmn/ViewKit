//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

/// As of now, this can be used either as a Main label, or a Property label
public struct Labeled: Sendable {

  public let key: PropertyLabel
  //  public let key: String
  //  public let abbreviatedKey: String?

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  /// ```
  public let separatorOverride: String?
  public let value: DisplayFragment?

  /// If no value provided, will inherit from `DisplayString/format`
  public let formatOverride: FloatDisplayFormat?

  /// Providing a value for `separator` or `format` will override
  /// the defaults defined in `DisplayString/format`
  public init(
    _ key: String,
    value: Any?,
    separator: String? = nil,
    format: FloatDisplayFormat? = nil
  ) {
    self.key = PropertyLabel(key)
    self.separatorOverride = separator
    self.value = value.map { DisplayFragment.make(from: $0) }
    self.formatOverride = format
  }
}

extension Labeled {

  public var block: DisplayBlock {
    .labeled(self)
    //    .labeled(key: key, separator: separator, value: value)
  }

  public func toString(using format: FloatDisplayFormat) -> String? {

    let effectiveFormat = formatOverride ?? format

    //    key: String,
    //    value: DisplayFragment?,
    //    separator: String,
    //    using format: FloatDisplayFormat
    //  ) -> String {
    //    let valueText = value?.render(using: format) ?? "nil"
    //    return key + separator + valueText

    let valueString = value?.render(using: effectiveFormat)
    let labelString = key.toString(using: effectiveFormat)

  }

  //  public func labelStyle(_ style: PropertyLabel.Style) -> Labeled {
  //    var format = formatOverride ?? .default
  //    format.labelStyle = style
  //    return Labeled(
  //      key: key,
  //      value: value,
  //      separator: separator,
  //      formatOverride: format
  //    )
  //  }

  //  public static func toString(
  //    key: String,
  //    value: DisplayFragment?,
  //    separator: String,
  //    using format: FloatDisplayFormat
  //  ) -> String {
  //    let valueText = value?.render(using: format) ?? "nil"
  //    return key + separator + valueText
  //  }
}

//  private init(
//    key: String,
//    value: Any?,
//    separator: String,
//    formatOverride: FloatDisplayFormat?
//  ) {
//    self.key = key
//    self.separator = separator
//    self.value = value.map { DisplayFragment.make(from: $0) }
//    self.formatOverride = formatOverride
//  }

//}
