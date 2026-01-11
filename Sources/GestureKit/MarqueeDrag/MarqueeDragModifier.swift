//
//  MarqueeDragGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//


import SwiftUI

public struct MarqueeDragModifier: ViewModifier {
  @Environment(\.shouldRenderDragRect) private var shouldRenderDragRect
  @State private var rect: CGRect?

  let isEnabled: Bool
  let dragThreshold: CGFloat
  let didUpdateRect: (PointerPhase) -> Void

  public func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        MarqueeDragGesture(rect: $rect, dragThreshold: dragThreshold, didUpdateRect: didUpdateRect),
        isEnabled: isEnabled
      )

      .modifier(DrawMarqueeModifier(rect: rect, isEnabled: shouldRenderDragRect))
  }
}
extension View {
  public func marqueeDrag(
    isEnabled: Bool = true,
    dragThreshold: CGFloat = 5,
    didUpdateRect: @escaping (PointerPhase) -> Void = { _ in }
  ) -> some View {
    self.modifier(
      MarqueeDragModifier(
        isEnabled: isEnabled,
        dragThreshold: dragThreshold,
        didUpdateRect: didUpdateRect
      )
    )
  }
}
