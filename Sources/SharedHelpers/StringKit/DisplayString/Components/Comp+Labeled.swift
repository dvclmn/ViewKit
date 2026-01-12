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
//    value: (any StringConvertible)?,
    separator: String = ": "
  ) {
    self.key = key
    self.value = DisplayBlock.displayBlock(for: value)
    self.separator = separator
  }
}

extension Labeled: StringConvertible {
//extension Labeled: StyledStringConvertible {
  public var toString: String {
//  public var toStyledString: StyledString {

    let labelPart = "\(key)\(separator)"
    let valuePart = value?.toString ?? "nil"
    return labelPart + valuePart
    //    return StyledString("\(key)\(separator)\(valuePart)")

  }
}

