//
//  NSFont.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

#if canImport(AppKit)
import AppKit
import SwiftUI

extension Font {
  public init(_ nsFont: NSFont) {
    self = Font(nsFont as CTFont)
  }
}

extension NSFont {
  
  public func italic() -> NSFont {
    let manager = NSFontManager.shared
    return manager.convert(
      self,
      toHaveTrait: .italicFontMask
    )
  }

  func monospaced() -> NSFont {
    let descriptor = fontDescriptor.withDesign(.monospaced) ?? fontDescriptor
    return NSFont(descriptor: descriptor, size: pointSize) ?? self
  }

  /// Corresponds to SwiftUI's
  /// `Font/system(size:weight:design:) -> Font`
  /// Gets a system font with specified size, weight, and design.
  public static func preferredFont(
    size: CGFloat,
    weight: Font.Weight? = nil,
    design: Font.Design? = nil
  ) -> NSFont {
    /// Start with system font descriptor
    let system = NSFont.systemFont(ofSize: size, weight: weight?.toNSFontWeight ?? .regular)
    let descriptor = system.fontDescriptor

    /// Apply design only if non-default
    let withDesign: NSFontDescriptor

    if let design {
      withDesign = descriptor.withDesign(design.toNSFontDesign) ?? descriptor
    } else {
      withDesign = descriptor
    }

    return NSFont(
      descriptor: withDesign,
      size: size
    ) ?? system
  }

  /// Corresponds to SwiftUI's
  /// `Font/system(_ style:design:weight:) -> Font`
  /// Gets a system font that uses the specified style, design, and weight.
  ///
  /// May not preserve some details of certain styles, not sure
  public static func preferredFont(
    for style: Font.TextStyle,
    design: Font.Design? = nil,
    weight: Font.Weight? = nil
  ) -> NSFont {
    /// First get the preferred NSFont for the given style.
    /// Importantly, not the preferred Font Descriptor, as this seems not to work.
    let preferred = NSFont.preferredFont(forTextStyle: style.toNSTextStyle)

    /// Helpfully, we seem to be able to get the font size from this preferred Font
    let fontSize = preferred.pointSize

    /// Which we can then pass directly to the above ``AppKit/NSFont/preferredFont(size:weight:design:)``
    let nsFont = NSFont.preferredFont(
      size: fontSize,
      weight: weight,
      design: design
    )
    return nsFont
  }
  
  public var prettyDescription: String {
    let ptSize = pointSize
    let name = displayName ?? fontName
    return "\(name), at \(ptSize)pt."
  }

}
#endif
