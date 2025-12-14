//
//  SmoothMaskModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/9/2025.
//

import SharedHelpers
import SwiftUI

@available(macOS 14.0, *)
public struct SmoothMaskModifier: ViewModifier {

  let start: UnitPoint
  let end: UnitPoint
  let curve: UnitCurve
  let isEnabled: Bool

  public func body(content: Content) -> some View {
    content
      .mask {
        ZStack {
          Color.black

          SmoothLinearGradient(
            from: Color.black,
            to: Color.clear,
            startPoint: start,
            endPoint: end,
            curve: curve
          )
          .opacity(isEnabled ? 1 : 0)

        }
        .allowsHitTesting(false)
      }  // END mask
  }
}

@available(macOS 14.0, *)
extension View {
  public func smoothMask(
    from start: UnitPoint,
    to end: UnitPoint,
    curve: UnitCurve = .easeInOut,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      SmoothMaskModifier(
        start: start,
        end: end,
        curve: curve,
        isEnabled: isEnabled,
      )
    )
  }
}
