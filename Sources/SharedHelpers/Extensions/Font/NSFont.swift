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
  
  /// System font with specified size, weight, and design.
  public static func preferredFont(
    size: CGFloat,
    design: Font.Design = .default,
    weight: Font.Weight = .regular
  ) -> NSFont {
    // Start with system font descriptor
    let systemDescriptor = NSFont.systemFont(ofSize: size).fontDescriptor
    
    // Apply design trait
    let designed = systemDescriptor.withDesign(design.nsFontDesign) ?? systemDescriptor
    
    // Apply weight trait
    let weighted = designed.addingAttributes([
      .traits: [NSFontDescriptor.TraitKey.weight: weight.nsFontWeight]
    ])
    
    // Create font with explicit size
    return NSFont(descriptor: weighted, size: size) ?? NSFont.systemFont(ofSize: size, weight: weight.nsFontWeight)
  }
  
  
  /// A rough mapping of SwiftUI `Font.TextStyle` to AppKit preferred text styles.
  public static func preferredFont(
    _ style: Font.TextStyle,
    design: Font.Design = .default,
    weight: Font.Weight = .regular
  ) -> NSFont {
    let descriptor: NSFontDescriptor

    switch (style, design) {
      case (.largeTitle, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .title1)
      case (.title, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .title2)
      case (.headline, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .headline)
      case (.subheadline, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .subheadline)
      case (.body, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
      case (.callout, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .callout)
      case (.footnote, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .footnote)
      case (.caption, _), (.caption2, _):
        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .caption1)
      default:
        descriptor = NSFont.systemFont(ofSize: NSFont.systemFontSize).fontDescriptor
    }

    // Apply design trait
    let designed = descriptor.withDesign(design.nsFontDesign) ?? descriptor

    // Apply weight trait
    let weighted = designed.addingAttributes([
      .traits: [NSFontDescriptor.TraitKey.weight: weight.nsFontWeight]
    ])

    return NSFont(descriptor: weighted, size: 0) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
  }
}

extension Font.Design {
  fileprivate var nsFontDesign: NSFontDescriptor.SystemDesign {
    switch self {
      case .default: return .default
      case .monospaced: return .monospaced
      case .rounded: return .rounded
      case .serif: return .serif
      @unknown default: return .default
    }
  }
}

extension Font.Weight {
  fileprivate var nsFontWeight: NSFont.Weight {
    switch self {
      case .ultraLight: return .ultraLight
      case .thin: return .thin
      case .light: return .light
      case .regular: return .regular
      case .medium: return .medium
      case .semibold: return .semibold
      case .bold: return .bold
      case .heavy: return .heavy
      case .black: return .black
      default: return .regular
    }
  }
}
