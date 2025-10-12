//
//  CodablePresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI

public protocol SystemColourCodable: Codable {

}

//extension ColourCodable {
//  public func encode(color: Color) throws -> Data {
//    guard let codableColor = SystemColour(colour: color) else {
//      throw EncodingError.wrongColor
//    }
//    return try JSONEncoder().encode(codableColor)
//  }
//
//  public func decodeColor(from data: Data) throws -> Color {
//    let codableColor = try JSONDecoder()
//      .decode(SystemColour.self, from: data)
//    return Color(codableColour: codableColor)
//  }
//}

enum EncodingError: Error {
  case wrongColor
}

extension Color {
  init(codableColour: SystemColour) {
    self = switch codableColour {
      case .black: .black
      case .blue: .blue
      case .brown: .brown
      case .clear: .clear
      case .cyan: .cyan
      case .gray: .gray
      case .green: .green
      case .indigo: .indigo
      case .mint: .mint
      case .orange: .orange
      case .pink: .pink
      case .purple: .purple
      case .red: .red
      case .teal: .teal
      case .white: .white
      case .yellow: .yellow
      case .primary: .primary
      case .secondary: .secondary
      case .accentColor: .accentColor
    }
  }
}
