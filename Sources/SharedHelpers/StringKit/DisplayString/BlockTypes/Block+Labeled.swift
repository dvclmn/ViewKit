//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

//public protocol DisplayBlockConvertable {
//
//}

public struct Labeled: Sendable {
  //public struct Labeled<Value> {

  public let key: String

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  public let separator: String
  public let value: DisplayAtom?

  /// Previously had value as `any DisplayRenderable`, however this
  /// has been retired as it unneccesarily shadowed `FloatRenderable`
  //  public let value: Value?
  //  public let value: Any?
  //  public let value: (any StringRenderable)?
  //    public let value: DisplayBlock

  //  public let separator: String

  public init(
    _ key: String,
    value: Any?,
    //    value: DisplayAtom?,
    separator: String = ": "
  ) {
    self.key = key

    let labelValue =
      switch value {
        case let value as DisplayAtomRenderable: DisplayAtom(value)
        default: DisplayAtom(String(describing: value))
      }
    self.value = labelValue
    self.separator = separator
  }

  public var block: DisplayBlock {
    .labeled(key: key, separator: separator, value: value)
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

//extension Labeled: DisplayRenderable {
//  public func render(using format: FloatDisplayFormat) -> String {
//    let valuePart = value?.render(using: format) ?? "nil"
//    return key + separator + valuePart
//  }
//}
//
extension Labeled {

  //  public func renderLabel(using format: FloatDisplayFormat) -> String {
  //    let valuePart = value.
  //    return key + separator + valuePart
  //  }
  //  public var toDisplayBlock: DisplayBlock {
  //    DisplayBlock.labeled(self)
  ////  public func toDisplayBlock(using format: FloatDisplayFormat?) -> DisplayBlock {
  //
  ////    value?.render(using: format) ?? "nil"
  //  }
}

//extension DisplayBlock {

//  fileprivate static func semantic(for value: Any?) -> DisplayBlock {
//
//  }

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
//}
