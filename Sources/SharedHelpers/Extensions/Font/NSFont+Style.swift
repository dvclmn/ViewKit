//
//  NSFont+Italic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSFont {
  public enum FontStyle: Sendable {
    case body
    case italic
    case bold
    case boldItalic
    case semiBold
  }
}

extension NSFont.FontStyle {
  public func system(
    size: CGFloat,
    monospaced: Bool = false
  ) -> NSFont {
    let sys = NSFont.systemFont(ofSize: size)
    switch (self, monospaced) {
      case (.body, true):
        return NSFont.preferredFont(size: size, design: .monospaced)

      case (.body, false):
        return NSFont.preferredFont(size: size)

      case (.italic, true):
        let desc = sys.fontDescriptor.withSymbolicTraits([
          .italic, .monoSpace,
        ])
        return NSFont(descriptor: desc, size: size) ?? sys

      case (.italic, false):
        let desc = sys.fontDescriptor.withSymbolicTraits(.italic)
        return NSFont(descriptor: desc, size: size) ?? sys

      case (.bold, true):
        return NSFont.monospacedSystemFont(ofSize: size, weight: .bold)

      case (.bold, false):
        return NSFont.boldSystemFont(ofSize: size)

      case (.boldItalic, true):
        let desc = sys.fontDescriptor.withSymbolicTraits([
          .italic, .bold, .monoSpace,
        ])
        return NSFont(descriptor: desc, size: size) ?? sys

      case (.boldItalic, false):
        let desc = sys.fontDescriptor.withSymbolicTraits([
          .italic, .bold,
        ])
        return NSFont(descriptor: desc, size: size) ?? sys

      case (.semiBold, true):
        return NSFont.preferredFont(size: size, weight: .semibold)

      case (.semiBold, false):
        return NSFont.preferredFont(
          size: size,
          design: .monospaced,
          weight: .semibold
        )
    }
  }
}

//  public static func systemItalicFont(ofSize size: CGFloat) -> NSFont {
//
//
//    let font = NSFont(descriptor: desc, size: size) ?? system
//    return font
//  }
//
//  public static func systemBoldItalicFont(ofSize size: CGFloat) -> NSFont {
//    let system = NSFont.systemFont(ofSize: size)
//
//    let font = NSFont(descriptor: desc, size: size) ?? system
//    return font
//  }
//  public func italic() -> NSFont { withTraits(.italic) }
//  public func bold() -> NSFont { withTraits(.bold) }
//  public func boldItalic() -> NSFont { withTraits([.bold, .italic]) }
//  public func monospaced() -> NSFont { withTraits(.monoSpace) }

//  private func withTraits(_ traits: NSFontDescriptor.SymbolicTraits) -> NSFont {
//    let newDescriptor = self.fontDescriptor
//    newDescriptor.withSymbolicTraits(traits)
////    let newDescriptor = self.fontDescriptor.addingAttributes([.traits: traits])
//    return NSFont(descriptor: newDescriptor, size: 0) ?? self
//  }

//}
