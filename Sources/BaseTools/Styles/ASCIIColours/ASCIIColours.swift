//
//  ASCIIColours.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

public enum ASCIIColour: String, CaseIterable, Sendable {
  case asciiAmber
  case asciiBlack
  case asciiBlue
  case asciiBrightBlue
  case asciiBrightGreen
  case asciiBrightPurple
  case asciiBrightRed
  case asciiBrightTeal
  case asciiBrown
  case asciiDarkGrey
  case asciiGreen
  case asciiLightGrey
  case asciiOffBlack
  case asciiPhosphor
  case asciiPurple
  case asciiRed
  case asciiTeal
  case asciiWhite
  case asciiYellow

  public var colour: Color {
    Color(rawValue, bundle: .module)
  }

  /// US spelling alias for API consumers that prefer `color`.
  public var color: Color {
    colour
  }
}

extension Color {
  public init(ascii: ASCIIColour) {
    //  init(_ asciiColour: ASCIIColour) {
    self = ascii.colour
  }

  public static let asciiAmber: Color = .init(ascii: .asciiAmber)
  public static let asciiBlack: Color = .init(ascii: .asciiBlack)
  public static let asciiBlue: Color = .init(ascii: .asciiBlue)
  public static let asciiBrightBlue: Color = .init(ascii: .asciiBrightBlue)
  public static let asciiBrightGreen: Color = .init(ascii: .asciiBrightGreen)
  public static let asciiBrightPurple: Color = .init(ascii: .asciiBrightPurple)
  public static let asciiBrightRed: Color = .init(ascii: .asciiBrightRed)
  public static let asciiBrightTeal: Color = .init(ascii: .asciiBrightTeal)
  public static let asciiBrown: Color = .init(ascii: .asciiBrown)
  public static let asciiDarkGrey: Color = .init(ascii: .asciiDarkGrey)
  public static let asciiGreen: Color = .init(ascii: .asciiGreen)
  public static let asciiLightGrey: Color = .init(ascii: .asciiLightGrey)
  public static let asciiOffBlack: Color = .init(ascii: .asciiOffBlack)
  public static let asciiPhosphor: Color = .init(ascii: .asciiPhosphor)
  public static let asciiPurple: Color = .init(ascii: .asciiPurple)
  public static let asciiRed: Color = .init(ascii: .asciiRed)
  public static let asciiTeal: Color = .init(ascii: .asciiTeal)
  public static let asciiWhite: Color = .init(ascii: .asciiWhite)
  public static let asciiYellow: Color = .init(ascii: .asciiYellow)
}
