//
//  Models+Comparison.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

//struct FontComparison: Hashable {
//  let swiftUI: Font.TextStyle
//  let appKit: NSFont.TextStyle
//
//  init(_ swiftUI: Font.TextStyle, _ appKit: NSFont.TextStyle) {
//    self.swiftUI = swiftUI
//    self.appKit = appKit
//  }
//}

enum PlatformType: String, CaseIterable {
  case swiftUI
  case appKit
//  case appKitAlt

  var name: String {
    switch self {
      case .swiftUI: "SwiftUI"
      case .appKit: "AppKit"
//      case .appKitAlt: "AppKit Alt"
    }
  }

  func font(
    for style: Font.TextStyle,
    weight: Font.Weight? = nil
  ) -> Font {
    switch self {
      case .swiftUI: return Font.system(style)
      case .appKit: return Font(NSFont.preferredFont(for: style))
//      case .appKitAlt: return Font()
//        let preferred = NSFont.preferredFont(for: style)
//        let fontSize = preferred.pointSize
//        let nsFont = NSFont.preferredFont(
//          size: fontSize,
//          weight: .semibold,
//          design: .rounded
//        )
//        return Font(nsFont)
    }
  }

  func styleName(for style: Font.TextStyle) -> String {
    switch self {
      case .swiftUI:
        return String(describing: style)

      case .appKit:
        let text = style.toNSTextStyle.rawValue.split(
          separator: "TextStyle",
          maxSplits: 1,
          omittingEmptySubsequences: true
        )
        let result = String(text.last ?? "")
        return result

    }

  }
}
