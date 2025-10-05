//
//  StringComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/10/2025.
//

import SwiftUI

public enum StringComponent: Equatable, Hashable, StringConvertible {
  case plain(String)
  case attributed(AttributedString)

  public init(_ string: String) {
    self = .plain(string)
  }

  public init(_ attributed: AttributedString) {
    self = .attributed(attributed)
  }

  public var stringValue: String {
    switch self {
      case .plain(let str):
        return str
      case .attributed(let attrStr):
        return String(attrStr.characters)
    }
  }

  public var attributedString: AttributedString {
    switch self {
      case .plain(let str):
        return AttributedString(str)
      case .attributed(let attrStr):
        return attrStr
    }
  }

//  public var stringValue: String { string }
}

extension StringComponent {
  public func styledAutomatically() -> StringComponent {
    var new = self.attributedString
    let pattern = /:\s/
    new.findRangesAndApplyAttributes(
      matching: pattern,
      attributes: .highlighter
    )
    return Self.init(new)
  }

  public func applying(_ modifier: (inout AttributedString) -> Void) -> StringComponent {
    var new = self.attributedString
    modifier(&new)
    return Self.init(new)
  }

  public func bold() -> StringComponent {
    return self.applying { attr in
      attr.inlinePresentationIntent = .emphasized
    }

  }

//  public func italic() -> StringComponent {
//    var new = self
//    var attr = new.attributed
//    attr.inlinePresentationIntent = .emphasized
//    new.attributed = attr
//    return new
//  }
//
//  public func foregroundColor(_ colour: Color) -> StringComponent {
//    var new = self
//    var attr = new.attributed
//    attr.foregroundColor = colour
//    new.attributed = attr
//    return new
//  }
}

extension String {
  public func bold() -> StringComponent {
    StringComponent(self).bold()
  }
}
