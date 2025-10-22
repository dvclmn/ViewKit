//
//  QuickAlignOverlay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/10/2025.
//

import SwiftUI

//overlay<S, T>(_ style: S, in shape: T, fillStyle: FillStyle = FillStyle()) -> some View where S : ShapeStyle, T : Shape

public struct QuickAlignOverlayModifier<OverlayContent: View>: ViewModifier {

  let alignment: Alignment
  @ViewBuilder var overlayContent: OverlayContent

  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        overlayContent
      }
  }
}
extension View {
  /// Purely to remove the need to type alignment.
  public func overlay<V>(
    _ alignment: Alignment,
    @ViewBuilder content: () -> V
  ) -> some View where V: View {
    self.modifier(
      QuickAlignOverlayModifier(
        alignment: alignment,
        overlayContent: content
      )
    )
  }
}
