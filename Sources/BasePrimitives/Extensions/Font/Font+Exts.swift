//
//  Font+Exts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font.TextStyle {
  package var toNSTextStyle: NSFont.TextStyle {
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
      @unknown default: fatalError("Unknown Font.TextStyle")
    }
  }
}

extension Font.Design {
  package var toNSFontDesign: NSFontDescriptor.SystemDesign {
    switch self {
      case .default: .default
      case .serif: .serif
      case .rounded: .rounded
      case .monospaced: .monospaced
      @unknown default: fatalError("Unknown Font.Design")
    }
  }
}

extension Font.Weight {
  package var toNSFontWeight: NSFont.Weight {
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
      default: fatalError("Unknown Font.Weight")
    }
  }
}
