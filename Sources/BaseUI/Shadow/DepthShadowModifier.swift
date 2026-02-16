//
//  DepthShadowModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

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
        LayeredShadow(
          opacity: opacity,
          radius: radius,
          distanceY: distanceY,
          isOn: !hasDepth
        )
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
