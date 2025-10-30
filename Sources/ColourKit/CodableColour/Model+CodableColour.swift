//
//  Model+CodableColour.swift
//  Colour Library
//
//  Created by Dave Coleman on 3/9/2025.
//

/// `Color` can *take in* HSV values
/// `Color.Resolved` can *give* only RGB

// Credit to Natalia Panferova and Matthaus Woolard of
// https://nilcoalescing.com/blog/EncodeAndDecodeSwiftUIColor/

import NSUI
import SwiftUI

public enum CodableColour: Codable, Equatable, Hashable, Sendable {
  case hex(String)
  case rgb(RGBColour)
  case hsv(HSVColour)
  case rgbRaw(r: Double, g: Double, b: Double)
  case system(SystemColour)
  case mix(
    SystemColour,
    SystemColour,
    Double = 0.5
  )
}

extension CodableColour {
  public var colour: Color? {
    switch self {
      case .hex(let hex):
        return Color(hex: hex)

      case .rgb(let model):
        return Color(
          red: model.red,
          green: model.green,
          blue: model.blue,
          opacity: model.alpha
        )

      case .rgbRaw(let r, let g, let b):
        return Color(
          Color.RGBColorSpace.sRGB,
          red: r,
          green: g,
          blue: b
        )

      case .hsv(let model):
        return model.toColour

      case .system(let system):
        return system.toColour

      case .mix(let a, let b, let t):
        return ColourMix(a, b, mixAmount: t).colour
    }
  }
}

/// For encoding a representation of the color that can be used
/// on other platforms (e.g. web). We use `CGColor` and get
/// the color components from there.
public protocol ComponentColourCodable: Codable {

  /// Note, `cgColor` is only available on constant colors,
  /// will return `nil` if we try to access it on a dynamic color.
  var colour: Color { get }

}

extension ComponentColourCodable {

  // MARK: - Colour Components
  //
  //  public func encode() throws -> Data {
  //    //  public func encodeAsCGComponents(_ colour: Color) throws -> Data {
  //    guard let cgColor = colour.swiftUIColour.cgColor else {
  //      throw CodingError.wrongColor
  //    }
  //    return try JSONEncoder().encode(self.cgColor)
  //
  //  }
  //  public func decode(from data: Data) throws -> Color {
  //    let codableColor = try JSONDecoder()
  //      .decode(Self.self, from: data)
  //    return Color(cgColor: codableColor.cgColor)
  //
  //  }

}

struct CodableColorFromComponents: Codable {
  let cgColor: CGColor

  enum CodingKeys: String, CodingKey {
    case colorSpace
    case components
  }

  init(color: Color, env: EnvironmentValues) {
    self.cgColor = color.resolve(in: env).cgColor
  }
  init(cgColor: CGColor) {
    self.cgColor = cgColor
  }

  init(from decoder: Decoder) throws {
    let container =
      try decoder
      .container(keyedBy: CodingKeys.self)
    let colorSpace =
      try container
      .decode(String.self, forKey: .colorSpace)
    let components =
      try container
      .decode([CGFloat].self, forKey: .components)

    guard
      let cgColorSpace = CGColorSpace(name: colorSpace as CFString),
      let cgColor = CGColor(
        colorSpace: cgColorSpace, components: components
      )
    else {
      throw CodingError.wrongData
    }

    self.cgColor = cgColor
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    guard
      let colorSpace = cgColor.colorSpace?.name,
      let components = cgColor.components
    else {
      throw CodingError.wrongData
    }

    try container.encode(colorSpace as String, forKey: .colorSpace)
    try container.encode(components, forKey: .components)
  }
}

enum CodingError: Error {
  case wrongColor
  case wrongData
}
//public enum CodableColor {}

//extension CodableColor {
//public struct ColourCoder {

// MARK: - Platform/native approach

enum DecodingError: Error {
  case wrongType
}
//}
