//
//  CodablePresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI

extension CodableColour {
  public static func encode(color: Color) throws -> Data {
    guard let codableColor = SystemColour(colour: color) else {
      throw EncodingError.wrongColor
    }
    return try JSONEncoder().encode(codableColor)
  }

  public static func decodeColor(from data: Data) throws -> Color {
    let codableColor = try JSONDecoder()
      .decode(SystemColour.self, from: data)
    return Color(codableColour: codableColor)
  }

}

enum EncodingError: Error {
  case wrongColor
}

//extension Color {
//  public func toCodable(_ env: EnvironmentValues?) -> CodableColour {
//    return CodableColour(fromColor: self, env: env)
//  }
//}

extension Color {
  init(codableColour: SystemColour) {
    switch codableColour {
      case .black: self = .black
      case .blue: self = .blue
      case .brown: self = .brown
      case .clear: self = .clear
      case .cyan: self = .cyan
      case .gray: self = .gray
      case .green: self = .green
      case .indigo: self = .indigo
      case .mint: self = .mint
      case .orange: self = .orange
      case .pink: self = .pink
      case .purple: self = .purple
      case .red: self = .red
      case .teal: self = .teal
      case .white: self = .white
      case .yellow: self = .yellow
      case .primary: self = .primary
      case .secondary: self = .secondary
      case .accentColor: self = .accentColor
    //      case .indigo: self = .indigo
    //      case .cyan: self = .cyan
    //      case .blue: self = .blue
    }
  }
}

//extension CodableColour {
//  enum SystemColour: Codable {
//    case black
//    case blue
//    case brown
//    case clear
//    case cyan
//    case gray
//    case green
//    case indigo
//    case mint
//    case orange
//    case pink
//    case purple
//    case red
//    case teal
//    case white
//    case yellow
//
//    init?(color: Color) {
//      switch color {
//        case .black: self = .black
//        case .blue: self = .blue
//        case .brown: self = .brown
//        case .clear: self = .clear
//        case .cyan: self = .cyan
//        case .gray: self = .gray
//        case .green: self = .green
//        case .indigo: self = .indigo
//        case .mint: self = .mint
//        case .orange: self = .orange
//        case .pink: self = .pink
//        case .purple: self = .purple
//        case .red: self = .red
//        case .teal: self = .teal
//        case .white: self = .white
//        case .yellow: self = .yellow
//        default: return nil
//      }
//    }
//  }
//
//}
