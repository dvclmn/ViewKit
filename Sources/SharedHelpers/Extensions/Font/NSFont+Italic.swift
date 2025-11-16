//
//  NSFont+Italic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSFont {
  
  public func italic() -> NSFont {
    return self.withTraits(.italic)
//    let traits: NSFontDescriptor.SymbolicTraits = [.italic]
//    let newDescriptor = self.fontDescriptor.addingAttributes([.traits: traits])
//    return NSFont(descriptor: newDescriptor, size: 0) ?? self
  }
  
  public func boldItalic() -> NSFont {
    return self.withTraits([.bold, .italic])
//    let traits: NSFontDescriptor.SymbolicTraits = [.italic, .bold]
//    let newDescriptor = self.fontDescriptor.addingAttributes([.traits: traits])
//    return NSFont(descriptor: newDescriptor, size: 0) ?? self
  }
  
  private func withTraits(_ traits: NSFontDescriptor.SymbolicTraits) -> NSFont {
    let newDescriptor = self.fontDescriptor.addingAttributes([.traits: traits])
    return NSFont(descriptor: newDescriptor, size: 0) ?? self
  }

}
