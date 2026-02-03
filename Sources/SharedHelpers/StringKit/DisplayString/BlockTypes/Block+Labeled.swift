//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

public struct Labeled {

  public let key: String
  public let value: DisplayBlock?

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  public let separator: String

}

extension Labeled {
  //  public init(
  //    _ key: String,
  //    value: any PropertiesLabeled,
  //    separator: String = ": "
  //  ) {
  //    self.key = key
  //    self.value = DisplayBlock.
  ////    self.value = DisplayBlock.displayBlock(for: value)
  //    self.separator = separator
  //  }

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

//extension Labeled: StringRenderable {
//  public var toString: String { render(using: .default) }
//}

extension Labeled: DisplayRenderable {
  public func render(using format: DisplayFormat) -> String {
    let valuePart = value?.render(using: format) ?? "nil"
    //    let valuePart = value?.toString ?? "nil"
    return key + separator + valuePart
  }
}

extension DisplayBlock {

  static func semantic(for value: Any?) -> DisplayBlock {
    switch value {
      case let result as any PropertiesLabeled:
        .floatGroup(result)

      case let result as any FloatRenderable:
        .float(result)

      case let result as StringRenderable:
//      case let result as String:
          .text(result.toString)
        
      case let result as NSEvent.Phase:
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
