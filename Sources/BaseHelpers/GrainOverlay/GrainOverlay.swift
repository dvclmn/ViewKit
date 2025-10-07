//
//  File.swift
//
//
//  Created by Dave Coleman on 25/4/2024.
//

import SwiftUI
import SharedHelpers

@available(*, deprecated, message: "Unavailable, at least for now, whilst Assets catalogue whatever")
public struct GrainOverlay: ViewModifier {
  var opacity: Double

  public func body(content: Content) -> some View {
    content
      .overlay(
        Image(systemName: Icons.game.icon)
//        Image("fuji", bundle: .module)
          .resizable(resizingMode: .tile)
          .drawingGroup()
          .blendMode(.overlay)
          .opacity(opacity)
          .allowsHitTesting(false)
          .ignoresSafeArea()
      )
  }
}
extension View {
  public func grainOverlay(
    opacity: Double = 0.4
  ) -> some View {
    self.modifier(
      GrainOverlay(
        opacity: opacity
      )
    )
  }
}
