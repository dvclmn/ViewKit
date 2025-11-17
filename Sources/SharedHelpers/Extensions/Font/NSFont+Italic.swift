//
//  NSFont+Italic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSFont {

  public func italic() -> NSFont { withTraits(.italic) }
  public func bold() -> NSFont { withTraits(.bold) }
  public func boldItalic() -> NSFont { withTraits([.bold, .italic]) }

  private func withTraits(_ traits: NSFontDescriptor.SymbolicTraits) -> NSFont {
    let newDescriptor = self.fontDescriptor.addingAttributes([.traits: traits])
    return NSFont(descriptor: newDescriptor, size: 0) ?? self
  }

}
