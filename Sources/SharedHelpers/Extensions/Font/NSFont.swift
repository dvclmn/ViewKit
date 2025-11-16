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

  /// A rough mapping of SwiftUI `Font.TextStyle` to AppKit preferred text styles.
  //  public static func preferredFont(
  //    _ style: Font.TextStyle,
  //    design: Font.Design = .default,
  //    weight: Font.Weight = .regular
  //  ) -> NSFont {
  //    let descriptor: NSFontDescriptor
  //
  //    /// In the docs:
  //    /// ```
  //    /// func preferredFontDescriptor(
  //    ///   forTextStyle style: NSFont.TextStyle,
  //    ///   options: [NSFont.TextStyleOptionKey : Any] = [:]
  //    /// ) -> NSFontDescriptor
  //    /// ```
  //    switch (style, design) {
  //      case (.largeTitle, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .title1)
  //      case (.title, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .title2)
  //      case (.headline, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .headline)
  //      case (.subheadline, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .subheadline)
  //      case (.body, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
  //      case (.callout, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .callout)
  //      case (.footnote, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .footnote)
  //      case (.caption, _), (.caption2, _):
  //        descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .caption1)
  //      default:
  //        descriptor = NSFont.systemFont(ofSize: NSFont.systemFontSize).fontDescriptor
  //    }
  //
  //    // Apply design trait
  //    let designed = descriptor.withDesign(design.nsFontDesign) ?? descriptor
  //
  //    // Apply weight trait
  //    let weighted = designed.addingAttributes([
  //      .traits: [NSFontDescriptor.TraitKey.weight: weight.nsFontWeight]
  //    ])
  //
  //    return NSFont(descriptor: weighted, size: 0) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
  //  }
}

extension NSFont {
  /// A rough mapping of SwiftUI `Font.TextStyle` to AppKit preferred text styles.
  public static func preferredFont(
    _ style: Font.TextStyle,
    design: Font.Design = .default,
    weight: Font.Weight = .regular
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
    let preferredDesc = textStyle.map { NSFontDescriptor.preferredFontDescriptor(forTextStyle: $0) }
    let descriptorBase = preferredDesc ?? systemFont.fontDescriptor

    let descDesignAdded = descriptorBase.withDesign(design.nsFontDesign) ?? descriptorBase
    let descWeightAdded = descDesignAdded.addingAttributes([
      .traits: [TraitKey.weight: weight.nsFontWeight]
    ])

    return NSFont(descriptor: descWeightAdded, size: fontSize) ?? systemFont
  }
}

extension Font.Design {
  fileprivate var nsFontDesign: NSFontDescriptor.SystemDesign {
    switch self {
      case .default: .default
      case .monospaced: .monospaced
      case .rounded: .rounded
      case .serif: .serif
      @unknown default: .default
    }
  }
}

extension Font.Weight {
  fileprivate var nsFontWeight: NSFont.Weight {
    switch self {
      case .ultraLight: .ultraLight
      case .thin: .thin
      case .light: .light
      case .regular: .regular
      case .medium: .medium
      case .semibold: .semibold
      case .bold: .bold
      case .heavy: .heavy
      case .black: .black
      default: .regular
    }
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
