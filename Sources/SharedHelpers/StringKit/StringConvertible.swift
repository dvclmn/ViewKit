//
//  StringRenderable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import SwiftUI

public protocol StringRenderable {
  var toString: String { get }
}

// MARK: - Strings
extension String: StringRenderable {
  public var toString: String { self }
}

extension AttributedString: StringRenderable {
  public var toString: String { String(self.characters) }
}

extension Character: StringRenderable {
  public var toString: String { String(self) }
}

// MARK: - Primitives

extension Double: StringRenderable {
  public var toString: String { String(self) }
}

extension Int: StringRenderable {
  public var toString: String { String(self) }
}

extension Bool: StringRenderable {
  public var toString: String { self ? "true" : "false" }
}

extension Array: StringRenderable where Element: StringRenderable {
  public var toString: String { map(\.toString).joined(separator: ", ") }
}

extension CGSize: StringRenderable {
  public var toString: String { displayString }
}

extension NSRect: StringRenderable {
  public var toString: String { displayString }
}

extension CGPoint: StringRenderable {
  public var toString: String { displayString }
}

extension CGFloat: StringRenderable {
  public var toString: String { displayString }
}

// MARK: - Alignment
extension Alignment: StringRenderable {
  public var toString: String { self.displayName.standard }
}

extension Substring: StringRenderable {
  public var toString: String { String(self) }
}

//extension AnyRegexOutput: StringRenderable {
//  public var toString: String {
//    DisplayString {
//      self.summarise(key: \.name, sortedBy: \.name)
//      self.summarise(key: \.name, sortedBy: \.name)
//      self.summarise(key: \.range, sortedBy: \.name)
//      self.summarise(key: \.type, sortedBy: \.name)
//      self.summarise(key: \.value, sortedBy: \.name)
//    }.text
//  }
//}
