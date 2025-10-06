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
  public let value: BuilderElement?

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
    //    self.value =  StyledString()
    self.value = value.map { .text(StyledString($0.toString)) }
//    self.value = value.map { StyledString($0.toString) }
    self.separator = separator
  }
}

extension Labeled: StyledStringConvertible {
  public var toStyledString: StyledString {
    
//    let valuePart = String(describing: value?.toStyledString)
    let valuePart = value?.toStyledString ?? "nil"
    return StyledString("\(key)\(separator)\(valuePart)")
  }
}
