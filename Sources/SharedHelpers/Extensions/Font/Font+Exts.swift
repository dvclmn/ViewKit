//
//  Font+Exts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font.TextStyle {
  package var nsFontDesign: NSFont.TextStyle {
    switch self {
//      case .largeTitle: .title1
//      case .title: .title2
//      case .headline: .headline
//      case .subheadline: .subheadline
//      case .body: .body
//      case .callout: .callout
//      case .footnote: .footnote
//      case .caption, .caption2: .caption1
//
//      case .title2: .title2
//      case .title3: .title3
//        <#code#>
      @unknown default: .body
    }
  }
}

extension Font.Design {
  package var nsFontDesign: NSFontDescriptor.SystemDesign {
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
  package var nsFontWeight: NSFont.Weight {
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
