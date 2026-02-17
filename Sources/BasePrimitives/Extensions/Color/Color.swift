//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import SwiftUI

extension Color {
  public var toShapeStyle: AnyShapeStyle { AnyShapeStyle(self) }
}

enum OpacityPreset: CGFloat {
  case opacityBarelyThere = 0.03
  case opacityFaint = 0.1
  case opacityLow = 0.3
  case opacityMid = 0.5
  case opacityMedium = 0.65
  case opacityHigh = 0.85
  case opacityNearOpaque = 0.9
}

extension Color {
  
  public static let darkGrey: Color = .init(white: 0.28)
  public static let darkerGrey: Color = .init(white: 0.1)
  
  public func toCGColor(using environment: EnvironmentValues) -> CGColor{
    resolve(in: environment).cgColor
  }

  public var opacityBarelyThere: Color { opacity(OpacityPreset.opacityBarelyThere.rawValue) }
  public var opacityFaint: Color { opacity(OpacityPreset.opacityFaint.rawValue) }
  public var opacityLow: Color { opacity(OpacityPreset.opacityLow.rawValue) }
  public var opacityMid: Color { opacity(OpacityPreset.opacityMid.rawValue) }
  public var opacityMedium: Color { opacity(OpacityPreset.opacityMedium.rawValue) }
  public var opacityHigh: Color { opacity(OpacityPreset.opacityHigh.rawValue) }
  public var opacityNearOpaque: Color { opacity(OpacityPreset.opacityNearOpaque.rawValue) }

  public static var random: Color { self.random() }

  public static func random(randomOpacity: Bool = false) -> Color {
    Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1),
      opacity: randomOpacity ? .random(in: 0...1) : 1
    )
  }
  public var toNSColor: NSColor { NSColor(self) }
}


//extension Optional where Wrapped == Color {
//  public func withFallback(_ colour: Color) -> AnyShapeStyle {
//    self ?? AnyShapeStyle(colour)
//  }
//}
