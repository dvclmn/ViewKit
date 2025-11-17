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
    value: (any StringConvertible)?,
    separator: String = ": "
  ) {
    self.key = key
    self.value = value.map { .text(StyledString($0.toString)) }
    self.separator = separator
  }
}

extension Labeled: StyledStringConvertible {
  public var toStyledString: StyledString {

    let labelPart = StyledString("\(key)\(separator)", with: .secondary)
    let valuePart = value?.toStyledString ?? "nil"
    return labelPart + valuePart
    //    return StyledString("\(key)\(separator)\(valuePart)")

  }
}
