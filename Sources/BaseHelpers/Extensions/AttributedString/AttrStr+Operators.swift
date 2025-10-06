//
//  AttrStr+Operators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

extension AttributedString {
  public static func + (lhs: AttributedString, rhs: String) -> AttributedString {
    var result = lhs
    result.append(AttributedString(rhs))
    return result
  }

  public static func + (lhs: String, rhs: AttributedString) -> AttributedString {
    var result = AttributedString(lhs)
    result.append(rhs)
    return result
  }
}
