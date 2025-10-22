//
//  SystemColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/9/2025.
//

import SharedHelpers
import SwiftUI


//@CasePathable
public enum SystemColour: String, CaseIterable, Sendable, Codable, Equatable, Hashable, Identifiable {
  case black
  case blue
  case brown
  case clear
  case cyan
  case gray
  case green
  case indigo
  case mint
  case orange
  case pink
  case purple
  case red
  case teal
  case white
  case yellow
  case primary
  case secondary
  case accentColor

  public init?(colour: Color) {
    //    print("Attempting to convert native Color `\(colour)` to a `SystemColour`")
    let result: Self? =
      switch colour {
        case .red: SystemColour.red
        case .blue: SystemColour.blue
        case .teal: SystemColour.teal
        case .green: SystemColour.green
        case .orange: SystemColour.orange
        case .yellow: SystemColour.yellow
        case .pink: SystemColour.pink
        case .purple: SystemColour.purple
        case .indigo: SystemColour.indigo
        case .mint: SystemColour.mint
        case .cyan: SystemColour.cyan
        case .brown: SystemColour.brown
        case .gray: SystemColour.gray
        case .black: SystemColour.black
        case .white: SystemColour.white
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

}

//extension RGBColour {
//public static var black: Self { RGBCo }
//public static var blue: Self {  }
//public static var brown: Self {  }
//public static var clear: Self {  }
//public static var cyan: Self {  }
//public static var gray: Self {  }
//public static var green: Self {  }
//public static var indigo: Self {  }
//public static var mint: Self {  }
//public static var orange: Self {  }
//public static var pink: Self {  }
//public static var purple: Self {  }
//public static var red: Self {  }
//public static var teal: Self {  }
//public static var white: Self {  }
//public static var yellow: Self {  }
//public static var primary: Self {  }
//public static var secondary: Self {  }
//public static var accentColor: Self {  }
//
//}
