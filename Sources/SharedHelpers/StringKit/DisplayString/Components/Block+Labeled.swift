//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

public struct Labeled {

  public let key: String
  public let value: DisplayBlock?

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  public let separator: String

  public init(
    _ key: String,
    value: Any?,
    separator: String = ": "
  ) {
    self.key = key
    self.value = DisplayBlock.displayBlock(for: value)
    self.separator = separator
  }
}

extension Labeled: StringConvertible {
  public var toString: String {
    let valuePart = value?.toString ?? "nil"
    return key + separator + valuePart
  }
}

extension DisplayBlock {
  public static func displayBlock(for value: Any?) -> DisplayBlock {
    let text = string(for: value)
    return DisplayBlock.text(text)
  }
  
  private static func string(for value: Any?) -> String {
    guard let value else { return "nil" }
    guard let convertible = value as? StringConvertible else { return String(describing: value) }
    return convertible.toString
  }
  
}
