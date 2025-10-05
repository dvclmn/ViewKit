//
//  StringComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/10/2025.
//

import SwiftUI

public struct StringComponent: StringConvertible {
  public var plain: String
  public var attributed: AttributedString

  public init(_ string: String) {
    self.plain = string
    self.attributed = AttributedString(string)
  }

  public init(_ attributed: AttributedString) {
    self.plain = String(attributed.characters)
    self.attributed = attributed
  }

  public var stringValue: String { plain }
}

extension StringComponent {
  public func styledAutomatically() -> StringComponent {
    var new = self
    let pattern = /\sx\s/
    new.attributed.findRangesAndApplyAttributes(
      matching: pattern,
      attributes: .highlighter
    )
    return new
    //    if new.plain.contains(" x ") {
    //      var attr = new.attributed
    //      if let range = attr.range(of: " x ") {
    //        attr[range].foregroundColor = .secondary
    //      }
    //      new.attributed = attr
    //    }
    //    return new
  }

  public func bold() -> StringComponent {
    var new = self
    var attr = new.attributed
    attr.inlinePresentationIntent = .stronglyEmphasized
    new.attributed = attr
    return new
  }

  public func italic() -> StringComponent {
    var new = self
    var attr = new.attributed
    attr.inlinePresentationIntent = .emphasized
    new.attributed = attr
    return new
  }

  public func foregroundColor(_ colour: Color) -> StringComponent {
    var new = self
    var attr = new.attributed
    attr.foregroundColor = colour
    new.attributed = attr
    return new
  }
}

extension String {
  public func bold() -> StringComponent {
    StringComponent(self).bold()
  }
}
