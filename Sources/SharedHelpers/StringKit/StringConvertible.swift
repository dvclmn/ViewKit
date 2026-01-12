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

extension Int: StringConvertible {
  public var toString: String { String(self) }
}

extension Bool: StringConvertible {
  public var toString: String { self ? "true" : "false" }
}

extension Array: StringConvertible where Element: StringConvertible {
  public var toString: String { map(\.toString).joined(separator: ", ") }
}

extension CGSize: StringConvertible {
  public var toString: String { displayString }
}

extension NSRect: StringConvertible {
  public var toString: String { displayString }
}

extension CGPoint: StringConvertible {
  public var toString: String { displayString }
}

extension CGFloat: StringConvertible {
  public var toString: String { displayString }
}

// MARK: - Alignment
extension Alignment: StringConvertible {
  public var toString: String { self.displayName.standard }
}

extension Substring: StringConvertible {
  public var toString: String { String(self) }
}

extension AnyRegexOutput: StringConvertible {
  public var toString: String {
    DisplayString {
      self.summarise(key: \.name)
      self.summarise(key: \.name)
      self.summarise(key: \.range)
      self.summarise(key: \.type)
      self.summarise(key: \.value)
    }.text
  }
}
