//
//  StringConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import SwiftUI

public protocol StringConvertible {
  var toString: String { get }
}

// MARK: - Strings
extension String: StringConvertible {
  public var toString: String { self }
}

extension AttributedString: StringConvertible {
  public var toString: String { String(self.characters) }
}

extension Character: StringConvertible {
  public var toString: String { String(self) }
}

// MARK: - Primitives

extension Double: StringConvertible {
  public var toString: String { String(self) }
}
extension CGFloat: StringConvertible {
  public var toString: String { self.displayString }
}

extension Int: StringConvertible {
  public var toString: String { String(self) }
}

extension Bool: StringConvertible {
  public var toString: String { self ? "true" : "false" }
}

extension Array: StringConvertible where Element: StringConvertible {
  public var toString: String { map(\.toString).joined(separator: ", ") }
}

// MARK: - Alignment
extension Alignment: StringConvertible {
  public var toString: String { self.displayName.standard }
}

// MARK: - String, Ranges, Regex
extension Range<String.Index>: StringConvertible {
  public var toString: String { self.description }
}

extension Substring: StringConvertible {
  public var toString: String { String(self) }
}

extension AnyRegexOutput: StringConvertible {
  public var toString: String {
    DisplayString {
      self.summarise(key: \.name)
      self.summarise(key: \.range)
      self.summarise(key: \.type)
      self.summarise(key: \.value)
    }.plainText
  }
}
