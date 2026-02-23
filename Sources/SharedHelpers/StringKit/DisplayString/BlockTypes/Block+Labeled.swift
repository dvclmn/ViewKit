//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

public struct Labeled {

  public let key: String
  public let value: (any DisplayRenderable)?
  //  public let value: DisplayBlock?

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
    self.value = DisplayBlock.semantic(for: value)
    self.separator = separator
  }
}

extension Labeled: DisplayRenderable {
  public func render(using format: FloatDisplayFormat) -> String {
    let valuePart = value?.render(using: format) ?? "nil"
    return key + separator + valuePart
  }
}

extension Labeled {
  public func renderValue(using format: FloatDisplayFormat) -> String {
    value?.render(using: format) ?? "nil"
  }
}

extension DisplayBlock {

  fileprivate static func semantic(for value: Any?) -> DisplayBlock {
    switch value {
      case let result as any PropertiesLabeled:
        .floatGroup(result)

      case let result as any FloatRenderable:
        .float(result)

      case let result as StringRenderable:
        .text(result.toString)

      case let result as NSEvent.Phase:
        .text(result.description)

      case let result as CustomStringConvertible:
        .text(result.description)

      case nil:
        .text("nil")

      default:
        .text(String(describing: value))
    }
  }

  //  public static func displayBlock(for value: Any?) -> DisplayBlock {
  //
  //    guard let value else { return.text("nil") }
  //    if let result = value as?
  ////    if let value
  //
  //    let text = string(for: value)
  //    return DisplayBlock.text(text)
  //  }
  //
  //  private static func string(for value: Any?) -> String {
  //
  //    guard let convertible = value as? StringRenderable else { return String(describing: value) }
  //    return convertible.toString
  //  }
}
