//
//  Compat+FontResolved.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font {
  public struct Compatible {
    /// Returns the CTFont opaque type that represents a CoreText
    /// font object.
    public var ctFont: CTFont
    
    /// Returns `true` if the resolved font has a bold trait according
    /// to CoreText or the font's weight is semi-bold or greater.
    public var isBold: Bool
    
    /// Returns `true` if the resolved font is italic.
    public var isItalic: Bool
    
    /// The point size of a resolved font.
    public var pointSize: CGFloat
    
    /// The weight of a resolved font.
    public var weight: Font.Weight
    
    /// The width of a resolved font.
    public var width: Font.Width
    
    /// The leading of a resolved font.
    public var leading: Font.Leading
    
    /// Returns `true` if a resolved font is monospaced, false otherwise.
    public var isMonospaced: Bool
    
    /// Returns `true` if the resolved font's lowercased characters
    /// use small caps.
    public var isLowercaseSmallCaps: Bool
    
    /// Returns `true` if the resolved font's uppercased characters
    /// use small caps.
    public var isUppercaseSmallCaps: Bool
    
    /// Returns `true` if all of the resolved font's characters
    /// use small caps.
    public var isSmallCaps: Bool
  }
}

extension Font {
  /// Will fall back either to the provided fallback, or a reasonable default
  public func toCTFont(
//    _ fallback: CTFont? = nil
    style: Font.TextStyle = .body,
    size: CGFloat? = nil
  ) -> CTFont {
    
//    let fallback = fallback ?? CTFont.init(.application, size: 14)
    if #available(macOS 14.0, iOS 17.0, *) {
    } else {
      return CTFon
    }
  }
  
}

/// Useful:
/// `EnvironmentValues/fontResolutionContext`
/// `Font/resolve(in:)`
///
/// `Font.Context`
/// Information used to resolve a font.
///
/// `Font.Resolved`
/// A concrete  representation of a Font that can be shown,
/// with a specific set of `EnvironmentValues`.
/// A `Resolved` font will always map to the same
/// `CTFont` on a given platform.
public struct FontResolvedModifier: ViewModifier {

  public func body(content: Content) -> some View {
    if #available(macOS 26, iOS 26, *) {
      content

    } else {

      content
    }
  }
}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
