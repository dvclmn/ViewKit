//
//  FontConversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

// Credit to shaps80:
// https://gist.github.com/shaps80/2d21b2ab92ea4fddd7b545d77a47024b

//import SwiftUI
//
//#if os(macOS)
//public typealias Font = NSFont
//public typealias FontDescriptor = NSFontDescriptor
//#else
//public typealias Font = UIFont
//public typealias FontDescriptor = UIFontDescriptor
//#endif
//
//extension Font {
//  public static var caption2: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize - 6)
//    #else
//    .preferredFont(forTextStyle: .caption2)
//    #endif
//  }
//
//  public static var caption: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize - 5)
//    #else
//    .preferredFont(forTextStyle: .caption1)
//    #endif
//  }
//
//  public static var footnote: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize - 4)
//    #else
//    .preferredFont(forTextStyle: .footnote)
//    #endif
//  }
//
//  public static var callout: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize - 1)
//    #else
//    .preferredFont(forTextStyle: .callout)
//    #endif
//  }
//
//  public static var body: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize)
//    #else
//    .preferredFont(forTextStyle: .body)
//    #endif
//  }
//
//  public static var subheadline: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize - 2)
//    #else
//    .preferredFont(forTextStyle: .subheadline)
//    #endif
//  }
//
//  public static var headline: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize, weight: .semibold)
//    #else
//    .preferredFont(forTextStyle: .headline)
//    #endif
//  }
//
//  public static var title3: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize + 3)
//    #else
//    .preferredFont(forTextStyle: .title3)
//    #endif
//  }
//
//  public static var title2: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize + 5)
//    #else
//    .preferredFont(forTextStyle: .title2)
//    #endif
//  }
//
//  public static var title: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize + 11)
//    #else
//    .preferredFont(forTextStyle: .title1)
//    #endif
//  }
//
//  public static var largeTitle: Font {
//    #if os(macOS)
//    .systemFont(ofSize: Font.systemFontSize + 17)
//    #else
//    .preferredFont(forTextStyle: .largeTitle)
//    #endif
//  }
//
//  public static func monospaced() -> Font {
//    #if os(macOS)
//    .monospacedSystemFont(ofSize: Font.systemFontSize, weight: .regular)
//    #else
//    .system(.body, design: .monospaced)
//    #endif
//  }
//}
//
//extension Font {
//
//  public enum Leading {
//    case loose
//    case tight
//  }
//
//  private func addingAttributes(_ attributes: [FontDescriptor.AttributeName: Any]) -> Font {
//    let font = Font(descriptor: fontDescriptor.addingAttributes(attributes), size: pointSize)
//    #if os(macOS)
//    return font!
//    #else
//    return font
//    #endif
//  }
//
//  public static func system(size: CGFloat, weight: Font.Weight, design: FontDescriptor.SystemDesign = .default) -> Font
//  {
//    let descriptor = Font.systemFont(ofSize: size).fontDescriptor
//      .addingAttributes([
//        FontDescriptor.AttributeName.traits: [
//          FontDescriptor.TraitKey.weight: weight.rawValue
//        ]
//      ]).withDesign(design)!
//
//    let font = Font(descriptor: descriptor, size: size)
//    #if os(macOS)
//    return font!
//    #else
//    return font
//    #endif
//  }
//
//  #if os(iOS)
//  public static func system(_ style: Font.TextStyle, design: FontDescriptor.SystemDesign = .default) -> Font {
//    let descriptor = FontDescriptor.preferredFontDescriptor(withTextStyle: style).withDesign(design)!
//    return Font(descriptor: descriptor, size: 0)
//  }
//  #endif
//
//  public func weight(_ weight: Font.Weight) -> Font {
//    addingAttributes([
//      FontDescriptor.AttributeName.traits: [
//        FontDescriptor.TraitKey.weight: weight.rawValue
//      ]
//    ])
//  }
//
//  public func italic() -> Font {
//    #if os(macOS)
//    let descriptor = fontDescriptor.withSymbolicTraits(.italic)
//    return Font(descriptor: descriptor, size: 0)!
//    #else
//    let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic)!
//    return Font(descriptor: descriptor, size: 0)
//    #endif
//  }
//
//  public func bold() -> Font {
//    #if os(macOS)
//    let descriptor = fontDescriptor.withSymbolicTraits(.bold)
//    return Font(descriptor: descriptor, size: 0)!
//    #else
//    let descriptor = fontDescriptor.withSymbolicTraits(.traitBold)!
//    return Font(descriptor: descriptor, size: 0)
//    #endif
//  }
//
//  public func leading(_ leading: Leading) -> Font {
//    #if os(macOS)
//    let descriptor = fontDescriptor.withSymbolicTraits(leading == .loose ? .looseLeading : .tightLeading)
//    return Font(descriptor: descriptor, size: 0)!
//    #else
//    let descriptor = fontDescriptor.withSymbolicTraits(leading == .loose ? .traitLooseLeading : .traitTightLeading)!
//    return Font(descriptor: descriptor, size: 0)
//    #endif
//  }
//
//}
