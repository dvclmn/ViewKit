//
//  File.swift
//
//
//  Created by Dave Coleman on 30/4/2024.
//

import Foundation
import SwiftUI

public struct ShadowDepth {
  var rounding: CGFloat
  var distance: CGFloat

  public init(rounding: CGFloat, distance: CGFloat) {
    self.rounding = rounding
    self.distance = distance
  }
}

public struct ShadowModifier: ViewModifier {

  var opacity: Double
  var radius: Double
  var distanceY: Double
  var depth: ShadowDepth?

  public func body(content: Content) -> some View {

    content
      .modifier(
        LayeredShadow(opacity: opacity, radius: radius, distanceY: distanceY, isOn: !hasDepth)
      )

      .background {
        if let depth = depth, opacity > 0.0 {
          RoundedRectangle(cornerRadius: depth.rounding)
            .fill(.ultraThinMaterial)
            .modifier(
              LayeredShadow(opacity: opacity, radius: radius, distanceY: distanceY, isOn: hasDepth)
            )
            .scaleEffect(min(1.0, max(0.0, depth.distance)))
        }

      }
  }

}

public struct LayeredShadow: ViewModifier {

  var opacity: Double
  var radius: Double
  var distanceY: Double
  var isOn: Bool

  public func body(content: Content) -> some View {
    content
      .shadow(color: .black.opacity(isOn ? opacity : 0), radius: radius * 0.5, x: 0, y: 2)
      .shadow(
        color: .black.opacity(isOn ? opacity * 0.5 : 0), radius: radius * 0.7, x: 0,
        y: max(1, (distanceY / 2))
      )
      .shadow(color: .black.opacity(isOn ? opacity : 0), radius: radius * 2, x: 0, y: distanceY)
  }
}

extension ShadowModifier {
  var hasDepth: Bool {
    self.depth != nil
  }
}

extension View {
  public func quickShadow(
    opacity: Double = 0.2,
    radius: Double = 4,
    distanceY: Double = 6,
    depth: ShadowDepth? = nil
  ) -> some View {
    self.modifier(
      ShadowModifier(
        opacity: opacity,
        radius: radius,
        distanceY: distanceY,
        depth: depth
      ))
  }
}

//public struct RoundedShadowModifier: ViewModifier {
//
//  let rounding: CGFloat
//  let backgroundColour: Color
//
//  public init(
//    rounding: CGFloat,
//    backgroundColour: Color
//  ) {
//    self.rounding = rounding
//    self.backgroundColour = backgroundColour
//  }
//
//  public func body(content: Content) -> some View {
//
//    content
//      .background {
//        Rectangle()
//          .fill(.regularMaterial)
//          .fill(backgroundColour.opacity(0.35))
//          .stroke(.white.opacity(0.04), style: .init(lineWidth: 1))
//      }
//    //        .compositingGroup()
//
//  }
//}
//public extension View {
//  func roundedShadow(
//    rounding: CGFloat = Styles.sizeSmall,
//    backgroundColour: Color = .black.opacity(0.8)
//  ) -> some View {
//    self.modifier(
//      RoundedShadowModifier(rounding: rounding, backgroundColour: backgroundColour)
//    )
//  }
//}
//
