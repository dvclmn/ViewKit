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

public struct StyledString: StringConvertible {
  public var string: AttributedString
  
  public init(_ string: AttributedString) {
    self.string = string
  }
  public init(_ string: String) {
    self.string = string.toAttributedString
  }
}

extension StyledString {
  public var stringValue: String { self.string.toString }
}

extension StyledString {

  private var patternPresets: [StyledPattern] {
    [
      StyledPattern(/:\s/, attributes: .highlighter),
      StyledPattern(/\sx\s/, attributes: .neonOrange),
    ]
  }

  private var stylePresets: StyledThing {
    StyledThing(patterns: patternPresets, sourceText: self.string)
  }

  public func styledAutomatically() -> Self {
    return patternPresets.reduce(StyledString("")) { partialResult, preset in
      self.applying { attr in
        attr.findRangesAndApplyAttributes(
          matching: preset.pattern,
          attributes: preset.attributes
        )
      }
    }
  }

  public func applying(_ modifier: (inout AttributedString) -> Void) -> Self {
    let new = self
    var attr = new.string
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
    StyledString(self).bold()
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
      self.summarise(key: \.name).description
//      self.summarise(key: \.range)
//      self.summarise(key: \.type)
//      self.summarise(key: \.value)
    }
    .output
  }
}
