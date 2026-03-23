//
//  SystemColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/9/2025.
//


//import CoreTools
import SwiftUI

public enum SystemColour: String, CaseIterable, Sendable, Codable,
  Equatable, Hashable, Identifiable
{
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
  case tertiary
  case quaternary
  case quinary
  case accentColor
  case link
}

extension SystemColour {

  public var id: String { rawValue }

  public var name: String {
    switch self {
      case .accentColor: "Accent"
      default: rawValue.capitalized
    }
  }

  public func withMix(_ colour: Self, _ amount: Double) -> Color {
    return self.toColour.mixCompatible(
      with: colour.toColour,
      by: amount,
      in: .perceptual
    )
  }

  public var toPrimitiveColour: PrimitiveColour? {
    PrimitiveColour(rawValue: self.rawValue)
  }
  
  public func rgbColour(in env: EnvironmentValues) -> RGBColour? {
    .init(fromSystem: self, env: env)
  }

}

extension SystemColour {
  public var hsvAdjustment: HSVAdjustment? {
    guard let nsColour = self.toNSColor else { return nil }
    let hue = nsColour.hueComponent
    let sat = nsColour.saturationComponent
    let val = nsColour.brightnessComponent
    return HSVAdjustment(h: hue, s: sat, v: val)
  }

  /// This unable to work, as HSVAdjustable only works in deltas
//  public func hsvAdjusted(by adjustment: HSVAdjustment) -> Color? {
//    guard let baseAdjustment = hsvAdjustment else { return nil }
//    let adjusted: HSVAdjustment = baseAdjustment.interpolated(
//      towards: adjustment
//    )
//    return adjusted.toColour()
//  }

}
