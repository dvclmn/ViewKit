//
//  StringConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI

public protocol StyledString: StringConvertible {
  var styledValue: AttributedString { get }
}
extension StyledString {
  public var stringValue: String { self.styledValue.toString }
}

public protocol StringConvertible {
  var stringValue: String { get }
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
    .output
  }
}
