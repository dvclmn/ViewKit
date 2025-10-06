//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// Aiming to allow this to be either *any* key-value
/// stlye builder element, such as
/// `Labeled("Name", value: model.name)`
///
/// Or also support `FloatDisplay`/`FloatGroup`, like
/// `Labeled()`
public struct Labeled {

  public let key: String
  public let value: StyledString?

  /// E.g. for `CGPoint`
  /// ```
  /// Label separator: ": "
  /// Result: X: 10
  public let separator: String

  public init(
    _ key: String,
    value: (any StyledStringConvertible)?,
    separator: String = ": "
  ) {
    self.key = key
    self.value = value?.toStyledString()
    //    self.value = value.map { StyledString($0.stringValue) }
    self.separator = separator
  }
}

extension Labeled: StyledStringConvertible {
  public func toStyledString() -> StyledString {
    let valuePart = value?.styledString ?? ""
    return StyledString("\(key)\(separator)\(valuePart)")
  }
}
