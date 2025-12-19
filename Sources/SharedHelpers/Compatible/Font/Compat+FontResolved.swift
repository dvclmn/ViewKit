//
//  Compat+FontResolved.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font {
  public func resolveCompatible(in context: Font.Context) -> Font.ResolvedCompatible {
    Font.ResolvedCompatible(font: self, context: context)
  }
}

extension Font {
  public struct ResolvedCompatible {
    let font: Font
    let context: Font.Context

    public init(font: Font, context: Font.Context) {
      self.font = font
      self.context = context
    }
  }
}

extension Font.ResolvedCompatible {
  public init?(font: Font?, context: Font.Context) {
    guard let font else { return nil }
    self.font = font
    self.context = context
  }
}


@available(macOS 26, iOS 26, *)
extension Font.ResolvedCompatible {
  public var fontResolved: Font.Resolved { font.resolve(in: context) }
  public var toNSFont: NSFont { fontResolved.ctFont as NSFont }

}

//    /// Returns the CTFont opaque type that represents a CoreText
//    /// font object.
//    public var ctFont: CTFont
//
//    /// Returns `true` if the resolved font has a bold trait according
//    /// to CoreText or the font's weight is semi-bold or greater.
//    public var isBold: Bool
//
//    /// Returns `true` if the resolved font is italic.
//    public var isItalic: Bool
//
//    /// The point size of a resolved font.
//    public var pointSize: CGFloat
//
//    /// The weight of a resolved font.
//    public var weight: Font.Weight
//
//    /// The width of a resolved font.
//    public var width: Font.Width
//
//    /// The leading of a resolved font.
//    public var leading: Font.Leading
//
//    /// Returns `true` if a resolved font is monospaced, false otherwise.
//    public var isMonospaced: Bool
//
//    /// Returns `true` if the resolved font's lowercased characters
//    /// use small caps.
//    public var isLowercaseSmallCaps: Bool
//
//    /// Returns `true` if the resolved font's uppercased characters
//    /// use small caps.
//    public var isUppercaseSmallCaps: Bool
//
//    /// Returns `true` if all of the resolved font's characters
//    /// use small caps.
//    public var isSmallCaps: Bool
//  }
//}
