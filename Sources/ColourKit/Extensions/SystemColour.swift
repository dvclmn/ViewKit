//
//  SystemColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/9/2025.
//

import SharedHelpers
import SwiftUI

public enum SystemColour: String, CaseIterable, Sendable, Codable, Equatable, Hashable, Identifiable {
  case red
  case orange
  case yellow
  case green
  case mint
  case teal
  case cyan
  case blue
  case indigo
  case purple
  case pink
  case brown
  case white
  case gray
  case black
  case clear
  case primary
  case secondary
  case accentColor

  public init?(colour: Color) {
    //    print("Attempting to convert native Color `\(colour)` to a `SystemColour`")
    let result: Self? =
      switch colour {
        case .red: SystemColour.red
        case .orange: SystemColour.orange
        case .yellow: SystemColour.yellow
        case .green: SystemColour.green
        case .mint: SystemColour.mint
        case .teal: SystemColour.teal
        case .cyan: SystemColour.cyan
        case .blue: SystemColour.blue
        case .indigo: SystemColour.indigo
        case .purple: SystemColour.purple
        case .pink: SystemColour.pink
        case .brown: SystemColour.brown
        case .white: SystemColour.white
        case .gray: SystemColour.gray
        case .black: SystemColour.black
        case .clear: SystemColour.clear
        case .primary: SystemColour.primary
        case .secondary: SystemColour.secondary
        case .accentColor: SystemColour.accentColor
        default: nil
      }

    guard let result else { return nil }
    self = result
  }

  //  public func opacity(_ opacity: Double) -> Color {
  //    return self.swiftUIColour.opacity(opacity)
  //  }

  public var id: String { rawValue }

  public var name: String {
    switch self {
      case .accentColor: "Accent"
      default: rawValue.capitalized
    }
  }

  public func withMix(_ colour: Self, _ amount: Double) -> Color {
    return self.toColour.mixCompatible(with: colour.toColour, by: amount, in: .perceptual)
  }

  public var toPrimitiveColour: PrimitiveColour? {
    PrimitiveColour(rawValue: self.rawValue)
  }

  public var toColour: Color {
    switch self {
      case .red: Color.red
      case .blue: Color.blue
      case .teal: Color.teal
      case .green: Color.green
      case .orange: Color.orange
      case .yellow: Color.yellow
      case .pink: Color.pink
      case .purple: Color.purple
      case .indigo: Color.indigo
      case .mint: Color.mint
      case .cyan: Color.cyan
      case .brown: Color.brown
      case .gray: Color.gray
      case .black: Color.black
      case .white: Color.white
      case .clear: Color.clear
      case .primary: Color.primary
      case .secondary: Color.secondary
      case .accentColor: Color.accentColor
    }
  }

  public func toNSColor(using colourSpace: NSColorSpace = .sRGB) -> NSColor? {

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
        case .primary: NSColor.labelColor
        case .secondary: NSColor.secondaryLabelColor
        case .accentColor: NSColor.controlAccentColor
      }
    guard let result = colour.usingColorSpace(colourSpace) else {
      print("Couldn't resolve NSColor using colourspace \(colourSpace), for `SystemColour` \(self.name)")
      return nil
    }
//    print("Successfully resolved NSColor for SystemColour.\(self.rawValue)")
    return result
  }

}

extension SystemColour {
  public var hsvAdjustment: HSVAdjustment? {
    guard let nsColour = self.toNSColor() else { return nil }
    let hue = nsColour.hueComponent
    let sat = nsColour.saturationComponent
    let val = nsColour.brightnessComponent
    return HSVAdjustment(h: hue, s: sat, v: val)
  }

  public func hsvAdjusted(by adjustment: HSVAdjustment) -> Color? {
    guard let baseAdjustment = hsvAdjustment else { return nil }
    let adjusted: HSVAdjustment = baseAdjustment.interpolated(towards: adjustment)
    return adjusted.toColour()
  }

}
