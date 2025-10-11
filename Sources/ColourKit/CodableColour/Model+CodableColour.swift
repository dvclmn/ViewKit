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

public struct CodableColor: Codable {
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


extension CodableColor {
  //public struct ColourCoder {
  
  // MARK: - Platform/native approach
  public struct Platform {
    public static func encode(_ colour: Color) throws -> Data {
      let platformColor = NSUIColor(colour)
      return try NSKeyedArchiver.archivedData(
        withRootObject: platformColor,
        requiringSecureCoding: true
      )
    }
    
    public static func decode(from data: Data) throws -> Color {
      guard
        let platformColor = try NSKeyedUnarchiver.unarchivedObject(
          ofClass: NSUIColor.self,
          from: data
        )
      else { throw DecodingError.wrongType }
      return Color(nsuiColor: platformColor)
    }
  }
  
  // MARK: - Colour Components
  public struct Components {
    public static func encode(_ colour: Color) throws -> Data {
      guard let cgColor = colour.cgColor else {
        throw CodingError.wrongColor
      }
      return try JSONEncoder().encode(CodableColor(cgColor: cgColor))
      
    }
    public static func decode(from data: Data) throws -> Color {
      let codableColor = try JSONDecoder()
        .decode(CodableColor.self, from: data)
      return Color(cgColor: codableColor.cgColor)
      
    }
  }
  
  enum DecodingError: Error {
    case wrongType
  }
}


//public protocol CodableColour {
//  var resolved: Color.Resolved { get set }
//  var name: String? { get set }
//  var colour: Color { get }
//
//  mutating func setResolved(
//    _ colour: Color,
//    environment: EnvironmentValues?
//  )
//  func environmentOrDefault(_ env: EnvironmentValues?) -> EnvironmentValues
//}
//
//public struct CodableColour: Sendable, Codable, Equatable, Hashable, Identifiable {
//  public let id: UUID
//  public var resolved: Color.Resolved
//  public var name: String?
//
//
//  private static let colourSpace: Color.RGBColorSpace = .sRGB
//
//  public init(
//    fromColor color: Color,
//    env: EnvironmentValues?,
//    name: String? = nil
//  ) {
//    self.init(resolved: color.resolve(in: Self.environmentOrDefault(env)), name: name)
//  }
//
//  public init(
//    resolved: Color.Resolved,
//    name: String? = nil
//  ) {
//    self.id = UUID()
//    self.resolved = resolved
//    self.name = name
//  }
//
//  public init(
//    r: Double,
//    g: Double,
//    b: Double,
//    a: Double = 1,
//    name: String? = nil
//  ) {
//    let resolved = Color.Resolved(
//      colorSpace: Self.colourSpace,
//      red: r.toFloat,
//      green: g.toFloat,
//      blue: b.toFloat,
//      opacity: a.toFloat
//    )
//    self.init(resolved: resolved, name: name)
//  }
//
//  public init(fromHSV hsv: HSVColour, env: EnvironmentValues?) {
//    let colourRep = hsv.swiftUIColour
//    self.init(
//      resolved: colourRep.resolve(in: Self.environmentOrDefault(env)),
//      name: hsv.name
//    )
//  }
//}
//
//extension CodableColour {
//
//  public var nameWithFallback: String { name ?? "Unknown" }
//
//  public var colour: Color { Color(resolved) }
//
//  public var toHSV: HSVColour {
//    return HSVColour(
//      fromRGB: resolved.red.toDouble,
//      g: resolved.green.toDouble,
//      b: resolved.blue.toDouble,
//      a: resolved.opacity.toDouble,
//      name: name
//    )
//  }
//
//  public mutating func setResolved(
//    _ colour: Color,
//    environment: EnvironmentValues?
//  ) {
//    resolved = colour.resolve(in: Self.environmentOrDefault(environment))
//  }
//
//  public static func environmentOrDefault(_ env: EnvironmentValues?) -> EnvironmentValues {
//    env ?? EnvironmentValues()
//  }
//
//  /// Returns `self` if no mod provided
//  public func contrastColour(
//    _ modification: ColourModification?,
//    _ env: EnvironmentValues?
//  ) -> Self {
//    guard let modification else { return self }
//    let modified = toHSV.contrastColour(modification: modification)
//    return CodableColour(fromHSV: modified, env: env)
//  }
//
//  public func contrastColour(
//    strength: ModificationStrengthPreset,
//    purpose: ColourPurpose = .legibility,
//    chroma: ColourChroma = .standard,
//    environment: EnvironmentValues?
//  ) -> Self {
////    guard let modification else { return self }
//    let modified = toHSV.contrastColour(
//      strength: strength,
//      purpose: purpose,
//      chroma: chroma
//    )
//    return CodableColour(fromHSV: modified, env: environment)
//  }
//
////  func applying(adjustment: HSVAdjustment) -> HSVColour {
////
////    let hsv = self.toHSV
////    let adjustedHue = adjustment.hue.map { hsv.hue + $0 } ?? hsv.hue
////
////    let adjustedSaturation =
////    adjustment.saturation.map { hsv.saturation + $0 } ?? hsv.saturation
////
////    let adjustedBrightness =
////    adjustment.brightness.map { hsv.brightness + $0 } ?? hsv.brightness
////
////    return HSVColour(
////      hueCyclic: adjustedHue,
////      saturation: adjustedSaturation,
////      brightness: adjustedBrightness,
////      alpha: hsv.alpha,
////      name: self.name
////    )
////  }
//}
//
////extension HSVColour {
////  init(fromCodable colour: CodableColour)
////}
//
//
//extension Color {
//  public func toCodable(_ env: EnvironmentValues?) -> CodableColour {
//    return CodableColour(fromColor: self, env: env)
//  }
//}
