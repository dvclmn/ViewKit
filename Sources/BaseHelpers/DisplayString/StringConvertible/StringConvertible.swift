//
//  StringConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI

public protocol StringConvertible {
  var stringValue: String { get }
}

public protocol StyledString: StringConvertible {
  var styledString: AttributedString { get }
//  init(fromAttributed attributed: AttributedString)
//  init(fromString string: String)
}

extension StyledString {
  public var stringValue: String { self.styledString.toString }
//  public init(fromAttributed attributed: AttributedString) {
//    
//  }
}

extension StyledString {

  private var patterns: [StyledPattern] {
    [
      StyledPattern(/:\s/, attributes: .highlighter),
      StyledPattern(/\sx\s/, attributes: .neonOrange),
    ]
  }

  private var autoStyled: StyledText {
    StyledText(patterns: patterns, sourceText: self.styledString)
  }

  public func styledAutomatically() -> Self {
    return self.styledAutomatically()
//    return self.autoStyled.output()
//    return self.applying {
//      $0.findRangesAndApplyAttributes(
//        matching: patterns,
//        attributes: .highlighter
//      )
//    }
  }

  public func applying(_ modifier: (inout AttributedString) -> Void) -> Self {
    var new = self
    var attr = new.styledString
    modifier(&attr)
    return new
  }

  public func italic() -> Self {
    return self.applying { attr in
      attr.inlinePresentationIntent = .emphasized
    }
  }

  public func bold() -> Self {
    return self.applying { attr in
      attr.inlinePresentationIntent = .stronglyEmphasized
    }
  }

  public func secondary() -> Self {
    return self.applying { attr in
      attr.foregroundColor = .secondary
    }
  }
}

extension String {
  public func bold() -> StyledString {
    self.attr
//    StyledString(self).bold()
  }
}

// MARK: - Primitives
extension String: StringConvertible {
  public var stringValue: String { self }
}

extension Int: StringConvertible {
  public var stringValue: String { String(self) }
}

extension Bool: StringConvertible {
  public var stringValue: String { self ? "true" : "false" }
}

extension Array: StringConvertible where Element: StringConvertible {
  public var stringValue: String {
    self.map(\.stringValue).joined(separator: ", ")
  }
}

// MARK: - Alignment
extension Alignment: StringConvertible {
  public var stringValue: String { self.displayName.standard }
}

// MARK: - String, Ranges, Regex
extension Range<String.Index>: StringConvertible {
  public var stringValue: String { self.description }
}

extension Substring: StringConvertible {
  public var stringValue: String { String(self) }
}

extension AnyRegexOutput: StringConvertible {
  public var stringValue: String {
    DisplayString {
      self.summarise(key: \.name)
      self.summarise(key: \.range)
      self.summarise(key: \.type)
      self.summarise(key: \.value)
    }
    .outputString
  }
}
