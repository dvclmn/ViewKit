//
//  Model+Colours.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//


import SwiftUI

public protocol ColourModel: Codable, Equatable, Identifiable {
  var colourSpace: Color.RGBColorSpace { get }
  var id: UUID { get }
  var name: String? { get }
  var alpha: Double { get set }
  var toColour: Color { get }
  var toOpaque: Self { get }
  mutating func opacity(_ opacity: Double)
  static func gray(_ brightness: Double, alpha: Double) -> Self
}

extension ColourModel {
  public mutating func opacity(_ opacity: Double) { alpha = opacity }
  public var colourSpace: Color.RGBColorSpace { .sRGB }
  public var nsColourSpace: NSColorSpace { .deviceRGB }
}

public enum ColourModelKind: String, Hashable, Codable, Sendable, CaseIterable, CaseCyclable, Identifiable {
  public static let defaultCase: ColourModelKind = .rgb
  
  case rgb
  case hsv
 
  public var id: String { rawValue}
  public var name: String {
    switch self {
      case .rgb: "RGB"
      case .hsv: "HSV"
    }
  }
  
  public var icon: IconLiteral {
    switch self {
      case .rgb: .symbol("camera.filters")
      case .hsv: .symbol("cone") // line.3.crossed.swirl.circle
    }
  }
  
  public var isRGB: Bool { self == .rgb }
  public var isHSV: Bool { self == .hsv }
}
