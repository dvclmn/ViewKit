//
//  IgnoreSafeBackground.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import SwiftUI

public struct IgnoreSafeBackgroundModifier: ViewModifier {

  let colours: [Color]
  let opacity: Double
  let mixIntensity: Double
  let ignoredEdges: Edge.Set
  public func body(content: Content) -> some View {
    content
      .background(
        colours.mixMultiple(by: mixIntensity).opacity(opacity),
        ignoresSafeAreaEdges: ignoredEdges
      )

  }
}

extension View {
  public func mixedColourBackground(
    colours: [Color],
    opacity: Double = 1,
    mixIntensity: Double = 0.5,
    ignoredEdges: Edge.Set
  ) -> some View {
    self.modifier(
      IgnoreSafeBackgroundModifier(
        colours: colours,
        opacity: opacity,
        mixIntensity: mixIntensity,
        ignoredEdges: ignoredEdges
      )
    )
  }
}
extension Array where Element == Color {
  public static let grayAndBlack: [Color] = [.gray, .black]
}
