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
  /// A rough mapping of SwiftUI `Font.TextStyle` to AppKit preferred text styles.
  public static func preferredFont(
    style: Font.TextStyle,
    design: Font.Design = .default,
    weight: Font.Weight
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
    return NSFont(descriptor: designed, size: 0) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
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

//extension NSFont {
//
//  func something(_ font: Font) -> NSFont {
//
//    let descriptor = NSFontDescriptor(
//      fontAttributes: <#T##[NSFontDescriptor.AttributeName : Any]?#>
//    )
////    switch font {
////      case .body: NSFont.
////      case .callout: NSFont.
////      case .caption: NSFont.
////      case .caption2: NSFont.
////      case .footnote: NSFont.
////      case .headline: NSFont.
////      case .largeTitle: NSFont.
////      case .subheadline: NSFont.
////      case .title: NSFont.
////      case .title2: NSFont.
////      case .title3: NSFont.
////      default: .body
////    }
//  }
//}
//
//extension NSFontDescriptor {
//
//}
