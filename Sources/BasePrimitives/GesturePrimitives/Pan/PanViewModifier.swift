//
//  TestPanGestureModifier.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

import BasePrimitives
import SwiftUI

#if canImport(AppKit)

public struct SwipeGestureModifier: ViewModifier {

  let isEnabled: Bool
  let onSwipeGesture: SwipeOutput

  public func body(content: Content) -> some View {
    content
      .overlay {
        if isEnabled {
          SwipeGestureView(onSwipeGesture)
        }
      }
  }
}
extension View {
  /// Aka pan gesture
  public func swipeGesture(
    isEnabled: Bool = true,
    _ onSwipeGesture: @escaping SwipeOutput
  ) -> some View {
    self.modifier(
      SwipeGestureModifier(
        isEnabled: isEnabled,
        onSwipeGesture: onSwipeGesture
      )
    )
  }
}
#endif
