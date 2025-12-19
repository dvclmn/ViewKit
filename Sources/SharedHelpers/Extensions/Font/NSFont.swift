//
//  NSFont.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import AppKit
import SwiftUI

extension Font {
  public init(_ nsFont: NSFont) {
    self = Font(nsFont as CTFont)
  }
}

extension NSFont {

  public static func system(
    _ style: FontStyle,
    size: CGFloat,
    monospaced: Bool = false
  ) -> NSFont {
    return style.system(
      size: size,
      monospaced: monospaced,
    )
  }

  
  /// Corresponds to SwiftUI's
  /// `Font/system(size:weight:design:) -> Font`
  /// Gets a system font with specified size, weight, and design.
  public static func preferredFont(
    size: CGFloat,
    weight: Font.Weight? = nil,
    design: Font.Design? = nil
//    size: CGFloat,
//    design: Font.Design? = nil,
////    design: Font.Design = .default,
//    weight: Font.Weight? = nil
////    weight: Font.Weight = .regular
  ) -> NSFont {
    /// Start with system font descriptor
    let system = NSFont.systemFont(ofSize: size, weight: weight.nsFontWeight)
    let descriptor = system.fontDescriptor

    /// Apply design trait
    let withDesign = descriptor.withDesign(design.nsFontDesign) ?? descriptor

    /// Apply weight trait
    let weighted = withDesign.addingAttributes([
      .traits: [TraitKey.weight: weight.nsFontWeight]
    ])

    /// Create font with explicit size
    return NSFont(
      descriptor: weighted,
      size: size
    ) ?? system
  }

  /// Corresponds to SwiftUI's
  /// `Font/system(_ style:design:weight:) -> Font`
  /// Gets a system font that uses the specified style, design, and weight.
  public static func preferredFont(
    _ style: Font.TextStyle,
    design: Font.Design? = nil,
    weight: Font.Weight? = nil
//    _ style: Font.TextStyle,
//    design: Font.Design = .default,
//    weight: Font.Weight = .regular
  ) -> NSFont {
    let textStyle: NSFont.TextStyle? =
      switch style {
        case .largeTitle: .title1
        case .title: .title2
        case .headline: .headline
        case .subheadline: .subheadline
        case .body: .body
        case .callout: .callout
        case .footnote: .footnote
        case .caption, .caption2: .caption1
        default: nil
      }
    let fontSize = NSFont.systemFontSize
    let systemFont = NSFont.systemFont(ofSize: fontSize)
    let preferredDesc = textStyle.map {
      NSFontDescriptor.preferredFontDescriptor(forTextStyle: $0)
    }
    let descriptorBase = preferredDesc ?? systemFont.fontDescriptor

    let descDesignAdded = descriptorBase.withDesign(design.nsFontDesign) ?? descriptorBase
    let descWeightAdded = descDesignAdded.addingAttributes([
      .traits: [TraitKey.weight: weight.nsFontWeight]
    ])

    return NSFont(descriptor: descWeightAdded, size: fontSize) ?? systemFont
  }
}

