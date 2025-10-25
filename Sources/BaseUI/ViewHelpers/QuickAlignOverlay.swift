//
//  QuickAlignOverlay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/10/2025.
//

import SwiftUI

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

public struct QuickAlignBackgroundModifier<OverlayContent: View>: ViewModifier {
  
  let alignment: Alignment
  @ViewBuilder var backgroundContent: OverlayContent
  
  public func body(content: Content) -> some View {
    content
      .background(alignment: alignment) {
        backgroundContent
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
  
  /// Purely to remove the need to type alignment.
  public func background<V>(
    _ alignment: Alignment,
    @ViewBuilder content: () -> V
  ) -> some View where V: View {
    self.modifier(
      QuickAlignBackgroundModifier(
        alignment: alignment,
        backgroundContent: content
      )
    )
  }
}
