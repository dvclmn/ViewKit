//
//  TextColumnMetric.swift
//  ViewKit
//
//  Created by Dave Coleman on 26/7/2026.
//

import CoreText
import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// The advance and line height of one glyph used to reserve text columns.
///
/// `TextColumns` normally uses SwiftUI to lay out a hidden digit, which is the
/// most faithful option for an inherited or custom font. Use this type when a
/// caller needs an explicit, reusable metric instead.
public struct TextColumnMetric: Hashable, Sendable {
  /// The glyph whose horizontal advance this metric represents.
  public let glyph: Unicode.Scalar

  /// The glyph's horizontal advance in points.
  public let advance: CGFloat

  /// The font's line height in points.
  public let lineHeight: CGFloat

  public var characterSize: CGSize {
    CGSize(width: advance, height: lineHeight)
  }

  public init(
    glyph: Unicode.Scalar = "0",
    advance: CGFloat,
    lineHeight: CGFloat,
  ) {
    self.glyph = glyph
    self.advance = advance
    self.lineHeight = lineHeight
  }

  /// Measures `glyph` directly from a concrete Core Text font.
  public init(font: CTFont, glyph: Unicode.Scalar = "0") {
    var character = UniChar(glyph.value)
    var glyphID = CGGlyph()
    CTFontGetGlyphsForCharacters(font, &character, &glyphID, 1)

    var advance = CGSize.zero
    CTFontGetAdvancesForGlyphs(font, .horizontal, &glyphID, &advance, 1)

    self.init(
      glyph: glyph,
      advance: advance.width,
      lineHeight: CTFontGetAscent(font) + CTFontGetDescent(font) + CTFontGetLeading(font),
    )
  }

  /// Returns the default monospaced-digit metric for a semantic text style.
  ///
  /// This is an explicit system-font prediction. It deliberately does not try
  /// to infer an arbitrary font from SwiftUI's environment on macOS 14–25.
  public static func monospacedDigit(for fontStyle: Font.TextStyle) -> Self {
    #if os(macOS)
    let preferred = NSFont.preferredFont(forTextStyle: fontStyle.nsTextStyle)
    let font = NSFont.monospacedSystemFont(ofSize: preferred.pointSize, weight: .regular)
    return Self(font: font as CTFont)
    #else
    let preferred = UIFont.preferredFont(forTextStyle: fontStyle.uiTextStyle)
    let font = UIFont.monospacedSystemFont(ofSize: preferred.pointSize, weight: .regular)
    return Self(font: font as CTFont)
    #endif
  }

  /// Resolves a SwiftUI font to an exact Core Text metric where SwiftUI exposes
  /// a concrete font resolution context.
  @available(macOS 26, iOS 26, *)
  public init(
    resolving font: Font,
    in context: Font.Context,
    glyph: Unicode.Scalar = "0",
  ) {
    self.init(font: font.resolve(in: context).ctFont, glyph: glyph)
  }
}


private extension Font.TextStyle {
#if os(macOS)
  var nsTextStyle: NSFont.TextStyle {
    switch self {
      case .largeTitle: .largeTitle
      case .title: .title1
      case .title2: .title2
      case .title3: .title3
      case .headline: .headline
      case .subheadline: .subheadline
      case .body: .body
      case .callout: .callout
      case .footnote: .footnote
      case .caption: .caption1
      case .caption2: .caption2
      @unknown default: .body
    }
  }
#else
  var uiTextStyle: UIFont.TextStyle {
    switch self {
      case .largeTitle: .largeTitle
      case .title: .title1
      case .title2: .title2
      case .title3: .title3
      case .headline: .headline
      case .subheadline: .subheadline
      case .body: .body
      case .callout: .callout
      case .footnote: .footnote
      case .caption: .caption1
      case .caption2: .caption2
      @unknown default: .body
    }
  }
#endif
}
