//
//  Model+CodableColour.swift
//  Colour Library
//
//  Created by Dave Coleman on 3/9/2025.
//

/// `Color` can *take in* HSV values
/// `Color.Resolved` can *give* only RGB

import NSUI
import SwiftUI

public protocol ColourCodable: Codable {
  
  associatedtype Colour: ColourModel
  var colour: Colour { get }
//  var cgColor: CGColor { get }
  
//  init(cgColor: CGColor)

}

extension ColourCodable {
  
  public func encodeAsPlatformColour() throws -> Data {
//  public func encodeAsPlatformColour(_ colour: Color) throws -> Data {
    let platformColor = NSUIColor(colour.swiftUIColour)
    return try NSKeyedArchiver.archivedData(
      withRootObject: platformColor,
      requiringSecureCoding: true
    )
  }

  public func decodeAsPlatformColour(from data: Data) throws -> Colour {
    guard
      let platformColor = try NSKeyedUnarchiver.unarchivedObject(
        ofClass: NSUIColor.self,
        from: data
      )
    else { throw DecodingError.wrongType }
    
    let swiftUIColor = Color(nsuiColor: platformColor)
    
    
  }

  // MARK: - Colour Components

  public func encodeAsCGComponents() throws -> Data {
//  public func encodeAsCGComponents(_ colour: Color) throws -> Data {
    guard let cgColor = colour.swiftUIColour.cgColor else {
      throw CodingError.wrongColor
    }
    return try JSONEncoder().encode(self.cgColor)

  }
  public func decodeAsCGComponents(from data: Data) throws -> Color {
    let codableColor = try JSONDecoder()
      .decode(Self.self, from: data)
    return Color(cgColor: codableColor.cgColor)

  }

}

public struct CodableColourTemp: Codable {
  let cgColor: CGColor

  enum CodingKeys: String, CodingKey {
    case colorSpace
    case components
  }

  public init(cgColor: CGColor) {
    self.cgColor = cgColor
  }

  public init(from decoder: Decoder) throws {
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

  public func encode(to encoder: Encoder) throws {
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
