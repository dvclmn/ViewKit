//
//  TestPanGestureModifier.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

import BasePrimitives
import SwiftUI

#if canImport(AppKit)

public struct PanGestureModifier: ViewModifier {

  let isEnabled: Bool
  let panDidChange: PanOutput

  public func body(content: Content) -> some View {
    content
      .overlay {
        if isEnabled {
          PanGestureView(onPanGesture: panDidChange)
        }
      }
  }
}
extension View {
  public func panGesture(
    isEnabled: Bool = true,
    _ panDidChange: @escaping PanOutput
  ) -> some View {
    self.modifier(
      PanGestureModifier(
        isEnabled: isEnabled,
        panDidChange: panDidChange
      )
    )
  }
}
#endif
