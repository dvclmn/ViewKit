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
  public let value: DisplayFragment?

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  /// ```
  public let separatorOverride: String?

  /// If no value provided, will inherit from `DisplayString/format`
  public let formatOverride: FloatDisplayFormat?

  /// Providing a value for `separator` or `format` will override
  /// the defaults defined in `DisplayString/format`
  public init(
    key: PropertyLabel,
    value: DisplayFragment?,
    separatorOverride: String? = nil,
    formatOverride: FloatDisplayFormat? = nil
  ) {
    self.key = key
    self.separatorOverride = separatorOverride
    self.value = value
    self.formatOverride = formatOverride
  }
}

extension Labeled {
  public init(
    _ key: String,
    value: Any?,
    separator: String? = nil,
    format: FloatDisplayFormat? = nil
  ) {
    self.init(
      key: PropertyLabel(key),
      value: value.map { DisplayFragment.make(from: $0) },
      separatorOverride: separator,
      formatOverride: format
    )
    //    self.key = PropertyLabel(key)
    //    self.separatorOverride = separator
    //    self.value = value.map { DisplayFragment.make(from: $0) }
    //    self.formatOverride = format
  }

  /// An init handy for ``PropertiesLabeled``
  public init(
    //    _ key: String,
    _ label: String,
    abbreviated: String? = nil,
    value: any FloatRenderable
      //    value: any PropertiesLabeled
      //    value: Any?,
      //    separator: String? = nil,
      //    format: FloatDisplayFormat? = nil
  ) {
    self.init(
      key: PropertyLabel(label, abbreviated: abbreviated),
      value: DisplayFragment(value),
      separatorOverride: nil,
      formatOverride: nil
    )
    //    self.key = PropertyLabel(label, abbreviated: abbreviated)
    //    self.separatorOverride = separator
    //    self.value = value.map { DisplayFragment.make(from: $0) }
    //    self.formatOverride = format
  }

  public var block: DisplayBlock {
    .labeled(self)
    //    .labeled(key: key, separator: separator, value: value)
  }

  public func toString(
    for kind: LabelKind,
    using format: FloatDisplayFormat
  ) -> String? {

    let effectiveFormat = formatOverride ?? format
    let effectiveSeparator = separatorOverride ?? kind.separatorKind
//    let effectiveSeparator = separatorOverride ?? format.separatorString(for: kind.separatorKind)

    //    key: String,
    //    value: DisplayFragment?,
    //    separator: String,
    //    using format: FloatDisplayFormat
    //  ) -> String {
    //    let valueText = value?.render(using: format) ?? "nil"
    //    return key + separator + valueText

    let valueString = valuePart(using: format)
//    let valueString = value?.render(using: effectiveFormat)
    let labelString = labelPart(with: format.labelStyle)
//    let labelString = key.toString(using: effectiveFormat)
    return

  }

  public func labelPart(with style: PropertyLabel.Style = .standard) -> String? {
    key.labelText(with: style)
  }

  public func valuePart(using format: FloatDisplayFormat = .default) -> String? {
    //    key.labelText(with: style)
    value?.render(using: format)
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
