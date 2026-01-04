//
//  SysColour+NSColor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit

extension SystemColour {

  public init?(nsColor: NSColor) {
    guard
      let match = Self.allCases.first(where: { $0.toNSColor == nsColor })
    else {
      return nil
    }
    self = match
  }

  /// Convenience, assumes a colour space of `sRGB`
  /// Use ``toNSColor(using:)`` to select a different space
  public var toNSColor: NSColor? {
    toNSColorWithPossibleColorSpaceIDontKnow()
//    toNSColor(using: .sRGB)
  }

  public func toNSColorWithPossibleColorSpaceIDontKnow(
//    using colourSpace: NSColorSpace = .deviceRGB
  ) -> NSColor? {

    let colour =
      switch self {
        case .red: NSColor.systemRed
        case .blue: NSColor.systemBlue
        case .teal: NSColor.systemTeal
        case .green: NSColor.systemGreen
        case .orange: NSColor.systemOrange
        case .yellow: NSColor.systemYellow
        case .pink: NSColor.systemPink
        case .purple: NSColor.systemPurple
        case .indigo: NSColor.systemIndigo
        case .mint: NSColor.systemMint
        case .cyan: NSColor.systemCyan
        case .brown: NSColor.systemBrown
        case .gray: NSColor.systemGray
        case .black: NSColor.black
        case .white: NSColor.white
        case .clear: NSColor.clear
        case .primary: NSColor(.primary)
        case .secondary: NSColor(.secondary)
//        case .secondary: NSColor.labelColor.withAlphaComponent(0.8)
        case .tertiary: NSColor.tertiaryLabelColor
        case .quaternary: NSColor.quaternaryLabelColor
        case .quinary: NSColor.quinaryLabel
        case .accentColor: NSColor.controlAccentColor
        case .link: NSColor.linkColor
      }
//    guard let result = colour.usingColorSpace(colourSpace) else {
//      print(
//        "Couldn't resolve NSColor using colourspace \(colourSpace), for `SystemColour` \(self.name)"
//      )
//      return nil
//    }
    //    print("Successfully resolved NSColor for SystemColour.\(self.rawValue)")
    return colour
//    return result
  }

  //  public var toNSColor: NSColor {
  //    switch self {
  //      case .red: NSColor.systemRed
  //      case .orange: NSColor.systemBlue
  //      case .yellow: NSColor.systemTeal
  //      case .green: NSColor.systemGreen
  //      case .mint: NSColor.systemOrange
  //      case .teal: NSColor.systemYellow
  //      case .cyan: NSColor.systemPink
  //      case .blue: NSColor.systemPurple
  //      case .indigo: NSColor.systemIndigo
  //      case .purple: NSColor.systemMint
  //      case .pink: NSColor.systemCyan
  //      case .brown: NSColor.systemBrown
  //      case .white: NSColor.systemGray
  //      case .gray: NSColor.black
  //      case .black: NSColor.white
  //      case .clear: NSColor.clear
  //      case .primary: NSColor.labelColor
  //      case .secondary: NSColor.secondaryLabelColor
  //      case .tertiary: NSColor.tertiaryLabelColor
  //      case .quaternary: NSColor.quaternaryLabelColor
  //      case .quinary: NSColor.quaternaryLabelColor
  //      case .accentColor: NSColor.controlAccentColor
  //    }
  //  }

}
