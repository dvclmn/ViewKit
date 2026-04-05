//
//  QuickBGShapeStyle.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/7/2025.
//

import SwiftUI

extension ShapeStyle where Self == TintedMaterial {
  public static var tintedMaterial: Self { .init() }
  public static func tintedMaterial(_ tint: Color) -> Self {
    .init(tint: tint)
  }
}

public struct TintedMaterial: ShapeStyle {
  let tint: Color
  
  public init(tint: Color = .primary) {
    self.tint = tint
  }
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    FillShapeStyle()
  }
}

//public struct TintedMaterial: ShapeStyle {
//  let image: Image?
////  let colour: Color
//  let dimming: Double
//  
//  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
//    /// May need to experiment, but I'm pretty sure I get the
//    /// nicest results with order (from lowest to highest, which
//    /// in SwiftUI modifiers reads from top to bottom)
//    ///
//    /// 1. Tint/image (providing the colour)
//    /// 2. Material
//    /// 3. Dimming (`Color.black`)
////    ZStack {
////      if let image {
////        ImagePaint(
////          image: image,
////          sourceRect: CGRect(origin: .zero, size: CGSize(1, 1))
////        )
////      }
////      TintShapeStyle()
//    Material.regularMaterial.resolve(in: <#T##EnvironmentValues#>)
//    Color.black.opacity(dimming)
////    }
//    
//  }
//}

/// What am I trying to do:
///
/// - I have styles for a background colour, 'holding' shape,
/// (e.g. rounded rect, capsule), stroke, etc, that I often come back to
/// - I want to simplify usage, call site
/// - `ShapeStyle` is used across so much of SwiftUI,
/// (Colour, Gradient, `.fill()`, etc) so it's an excellent
/// candidate for an entry point.
///
/// Important: for a custom shape style, we return something that
/// *already conforms* to `ShapeStyle`. A colour, gradient, whatever.
///
/// I'm not quite sure if this is the right place to define this
/// fill AND stroke style. I'll keep thinking

//public struct QuickBackgroundShapeStyle: ShapeStyle {
//  
//  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
//    return AnyShapeStyle(.regularMaterial)
//    
////    if environment.colorScheme == .light {
////      return Color.red.blendMode(.lighten)
////    } else {
////      return Color.red.blendMode(.darken)
////    }
//  }
//}
