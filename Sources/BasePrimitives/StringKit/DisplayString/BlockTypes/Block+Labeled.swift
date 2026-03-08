//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

public struct Labeled: Sendable {
  
  public let key: PropertyLabel
  //  public let key: String
  //  public let abbreviatedKey: String?
  
  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  /// ```
  /// Note: Have realised I could use 
  public let seperatorOverride: String?
  public let value: DisplayFragment?
  
  /// If no value provided, will inherit from `DisplayString/format`
  public let formatOverride: FloatDisplayFormat?
  
  public init(
    _ key: String,
    value: Any?,
    separator: String = ": ",
    formatOverride: FloatDisplayFormat?
  ) {
    self.key = PropertyLabel(key)
    self.separator = separator
    self.value = value.map { DisplayFragment.make(from: $0) }
    self.formatOverride = formatOverride
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
