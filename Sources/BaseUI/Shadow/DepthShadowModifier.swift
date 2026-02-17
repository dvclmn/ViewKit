//
//  DepthShadowModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import SwiftUI

public struct DepthShadowModifier: ViewModifier {

  let opacity: Double
  let radius: Double
  let distanceY: Double
  let depthIntensity: Double
  let isEnabled: Bool

  public func body(content: Content) -> some View {

    content
      .modifier(
        DepthShadowBaseModifier(
          opacity: opacity,
          radius: radius,
          distanceY: distanceY,
          isEnabled: isEnabled
        )
      )

      .background {
        if isEnabled, depthIntensity > 0 {
          RoundedRectangle(cornerRadius: 10 * depthIntensity)
            .fill(.ultraThinMaterial)
            .modifier(
              DepthShadowBaseModifier(
                opacity: opacity,
                radius: radius,
                distanceY: distanceY,
                isEnabled: isEnabled
              )
            )
            .scaleEffect(min(1, max(0, distanceY * depthIntensity)))
        }

      }
  }
}

extension View {
  public func depthShadow(
    opacity: Double = 0.2,
    radius: Double = 4,
    distanceY: Double = 6,
    depthIntensity: Double = 0.0,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      DepthShadowModifier(
        opacity: opacity,
        radius: radius,
        distanceY: distanceY,
        depthIntensity: depthIntensity,
        isEnabled: isEnabled
      )
    )
  }
}
