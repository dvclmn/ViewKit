//
//  FontTraits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/12/2025.
//

import AppKit
import SharedHelpers

public struct FontTraits: Hashable {
  let traits: NSFontDescriptor.SymbolicTraits
  
  /// The font this will have these traits merged with it
  let font: NSFont
}
extension FontTraits {
  public init(
    _ traits: NSFontDescriptor.SymbolicTraits,
    current font: NSFont
  ) {
    self.traits = traits
    self.font = font
  }
  
  
  private func constructFont(from attributes: TextAttributes) -> NSFont? {

//    print("Let's check attributes first: \(attributes.names)")

    let size = font.pointSize
    let desc = font.fontDescriptor.withSymbolicTraits(traits)
    let newFont = NSFont(descriptor: desc, size: size)
    return newFont
  }
}


