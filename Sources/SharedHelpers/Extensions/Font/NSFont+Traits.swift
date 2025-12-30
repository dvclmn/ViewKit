//
//  NSFont+Traits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit

extension NSFontDescriptor.SymbolicTraits {

  /// Where `scale` is a factor to multiply the `font`s
  /// point size by, for dialling in font size by fine adjustments
  public func constructFont(
    from font: NSFont,
    scale sizeScale: CGFloat = 1.0
  ) -> NSFont {
    let size = font.pointSize * sizeScale
    let desc = font.fontDescriptor.withSymbolicTraits(self)
    let newFont = NSFont(descriptor: desc, size: size) ?? font
    return newFont
  }

  public var prettyDescription: String {
    var desc: [String] = []
    if self.contains(.bold) {
      desc += ["Bold"]
    }
    if self.contains(.italic) {
      desc += ["Italic"]
    }
    if self.contains(.condensed) {
      desc += ["Condensed"]
    }
    if self.contains(.expanded) {
      desc += ["Expanded"]
    }
    if self.contains(.monoSpace) {
      desc += ["Monospace"]
    } else {
      desc += [String(describing: self)]
    }

    guard !desc.isEmpty else {
      return "No traits"
    }
    return desc.joined(separator: ", ")
  }

}
