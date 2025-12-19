//
//  Compat+FontResolved.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font {
  public struct Compatible {
    let font: Font
    let context: Font.Context
    
    public init(font: Font, context: Font.Context) {
      self.font = font
      self.context = context
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
  }
}

@available(macOS 26, iOS 26, *)
extension Font.Compatible {
  public var fontResolved: Font.Resolved { font.resolve(in: context) }
}

extension Font.Compatible {
  
  /// Will fall back to the provided style/design/weight,
  /// if true resolved Font not available
  public func toCTFont(
    
//    _ fallback: CTFont? = nil
//    style: Font.TextStyle = .body,
//    size: CGFloat? = nil
    _ style: Font.TextStyle,
    design: Font.Design? = nil,
    weight: Font.Weight? = nil
  ) -> CTFont {
    
//    let fallback = fallback ?? CTFont.init(.application, size: 14)
    if #available(macOS 26, iOS 26, *) {
//      let thing = self.font.resolve(in: self.context)
//      return thing.ctFont
      return fontResolved.ctFont
    } else {
      let nsFont = NSFont.preferredFont(
        style,
        design: design,
        weight: weight
      )
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
