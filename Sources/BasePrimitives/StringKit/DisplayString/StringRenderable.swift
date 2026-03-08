//
//  StringRenderable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import SwiftUI

public protocol StringRenderable: Sendable {
  var toString: String { get }
}

extension StringRenderable where Self: FloatRenderable {
  public var toString: String { render(using: .default) }
}

extension StringRenderable where Self: PropertiesLabeled {
  public var toString: String { renderProperties(using: .default) }
}

// MARK: - String types

extension String: StringRenderable {
  public var toString: String { self }
}

extension AttributedString: StringRenderable {
  public var toString: String { String(self.characters) }
}

extension Character: StringRenderable {
  public var toString: String { String(self) }
}

extension Substring: StringRenderable {
  public var toString: String { String(self) }
}

// MARK: - Primitives

extension Int: StringRenderable {
  public var toString: String { String(self) }
}

extension Bool: StringRenderable {
  public var toString: String { self ? "true" : "false" }
}

// MARK: - Alignment
extension Alignment: StringRenderable {
  public var toString: String { self.displayName.standard }
}

// MARK: - Collections
extension Array: StringRenderable where Element: StringRenderable {
  public var toString: String { map(\.toString).joined(separator: ", ") }
}


// MARK: - Floats

/// Covered already by FloatRenderable
//extension Double: StringRenderable {
//  public var toString: String { String(self) }
//}

//extension CGFloat: StringRenderable {
//  public var toString: String { "\(self)" }
//}
//
//extension Float: StringRenderable {
//  public var toString: String { String(self) }
//}



/// Covered already by PropertiesLabeled
//extension CGSize: StringRenderable {
//  public var toString: String { rende }
//}

//extension NSRect: StringRenderable {
//  public var toString: String { displayString }
//}

//extension CGPoint: StringRenderable {
//  public var toString: String { displayString }
//}

