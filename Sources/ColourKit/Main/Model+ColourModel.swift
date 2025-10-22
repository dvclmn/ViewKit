//
//  Model+Colours.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SwiftUI

public protocol EnvironmentResolvableColour {
  var toColour: Color { get }
  init(
    colour: Color,
    environment: EnvironmentValues,
    name: String?
  )
  init(
    resolved: Color.Resolved,
    name: String?
  )
}

public protocol ColourModel: Codable {
  var colourSpace: Color.RGBColorSpace { get }
  var name: String? { get }
  var alpha: Double { get set }
  mutating func opacity(_ opacity: Double)
  static func gray(_ brightness: Double, alpha: Double) -> Self
  
//  init(resolved: Color.Resolved, name: String?)
}


// MARK: - Extension methods
extension ColourModel {
  public mutating func opacity(_ opacity: Double) { alpha = opacity }
  public var colourSpace: Color.RGBColorSpace { .sRGB }
}


//extension Color: ColourModel, SwiftUIColourResolvable {
//  public init(
//    colour: Color,
//    environment: EnvironmentValues,
//    name: String?
//  ) {
//    self = colour
//  }
//  
//  public init(resolved: Resolved, name: String?) {
//    self.init(resolved)
//  }
//  
//  public static func gray(
//    _ brightness: Double,
//    alpha: Double
//  ) -> Color {
//    return Color(hue: 0, saturation: 0, brightness: brightness, opacity: alpha)
//  }
//  
//  public var colourSpace: RGBColorSpace { .sRGB }
//  public var name: String? { self.description }
//  public var swiftUIColour: Color { self }
//  public var alpha: Double {
//    get { self.toNSColour.alphaComponent }
//    set { self = self.opacity(newValue) }
//  }
//}

