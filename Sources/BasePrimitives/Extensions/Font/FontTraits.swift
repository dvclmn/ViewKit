//
//  FontTraits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/12/2025.
//

#if canImport(AppKit)
import AppKit

/// The below custom keys are located here for access
/// by both SharedHelpers and StringKit
extension String {
  public static var fontTraitsKey: String { "fontTraits" }
}

extension NSAttributedString.Key {
  public static let fontTraits = NSAttributedString.Key(String.fontTraitsKey)
}

extension NSFontDescriptor.SymbolicTraits: @retroactive Hashable {}

/// Bit easier having this custom type, than always trying to
/// conform `NSFontDescriptor.SymbolicTraits` to hashable etc
public struct FontTraits: Hashable, Sendable {
  let traits: NSFontDescriptor.SymbolicTraits
  let sizeScale: CGFloat
}

extension FontTraits {
  public init?(
    _ traits: NSFontDescriptor.SymbolicTraits?,
    sizeScale: CGFloat = 1.0
  ) {
    guard let traits else { return nil }
    self.init(traits: traits, sizeScale: sizeScale)
  }

  public func constructFont(using font: NSFont) -> NSFont? {
    self.traits.constructFont(from: font, scale: sizeScale)
  }

}

extension FontTraits: CustomStringConvertible {
  public var description: String {
    return self.traits.prettyDescription
  }
}
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
    let parts =
      boldItalicDescription
      + traitDescriptions

    return "[" + parts.joined(separator: ", ") + "]"
  }

  private var boldItalicDescription: [String] {
    switch (contains(.bold), contains(.italic)) {
      case (true, true): ["Bold Italic"]
      case (true, false): ["Bold"]
      case (false, true): ["Italic"]
      case (false, false): []
    }
  }

  private var traitDescriptions: [String] {
    [
      (Self.expanded, "Expanded"),
      (Self.condensed, "Condensed"),
      (Self.monoSpace, "Monospaced"),
      (Self.vertical, "Vertical"),
      (Self.UIOptimized, "UI Optimized"),
      (Self.tightLeading, "Tight Leading"),
      (Self.looseLeading, "Loose Leading"),
    ]
    .compactMap { contains($0.0) ? $0.1 : nil }
  }
}
#endif
