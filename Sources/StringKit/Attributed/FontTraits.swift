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
    self.traits.constructFont(font: <#T##NSFont#>, sizeScale: <#T##CGFloat#>)
  }
}

extension FontTraits: CustomStringConvertible {
  public var description: String {
    return self.traits.prettyDescription
  }

}
extension NSFontDescriptor.SymbolicTraits {
  public var prettyDescription: String {
    let traits = self
    let isBold = traits.contains(.bold)
    let isItalic = traits.contains(.italic)
    var names: [String] = []

    if isBold && isItalic {
      names.append("boldItalic")
    } else {
      if isBold {
        names.append("bold")
      }
      if isItalic {
        names.append("italic")
      }
    }

    if traits.contains(.expanded) {
      names.append("expanded")
    }
    if traits.contains(.condensed) {
      names.append("condensed")
    }
    if traits.contains(.monoSpace) {
      names.append("monospaced")
    }
    if traits.contains(.vertical) {
      names.append("vertical")
    }
    if traits.contains(.UIOptimized) {
      names.append("uiOptimized")
    }
    if traits.contains(.tightLeading) {
      names.append("tightLeading")
    }
    if traits.contains(.looseLeading) {
      names.append("looseLeading")
    }

    return "[" + names.joined(separator: ", ") + "]"
  }
}
