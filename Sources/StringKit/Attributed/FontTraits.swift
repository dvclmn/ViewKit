//
//  FontTraits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/12/2025.
//

import AppKit
import SharedHelpers

extension NSFontDescriptor.SymbolicTraits: @retroactive Hashable {}

/// Bit easier having this custom type, than always trying to
/// conform `NSFontDescriptor.SymbolicTraits` to hashable etc
public struct FontTraits: Hashable, Sendable {
  let traits: NSFontDescriptor.SymbolicTraits

}
extension FontTraits {
  public init?(
    _ traits: NSFontDescriptor.SymbolicTraits?,
  ) {
    guard let traits else { return nil }
    self.init(traits: traits)
  }

  public func constructFont(
    font: NSFont,
    sizeScale: CGFloat
  ) -> NSFont? {
    self.traits.constructFont(font: font, sizeScale: sizeScale)
  }
}
