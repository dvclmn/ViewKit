//
//  TestPanGestureModifier.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

#if canImport(AppKit)

/// Note: This size comes as deltas, which will need to be accrued
/// Modifiers == 'modifiers held'
public typealias PanOutput = (CGSize, InteractionPhase, Modifiers) -> Void

public struct PanGestureModifier: ViewModifier {

  let isEnabled: Bool
  let panDidChange: PanOutput

  public func body(content: Content) -> some View {
    content
      .overlay {
        if isEnabled {
          PanGestureView { delta, phase, modifiers in
            panDidChange(delta, phase, modifiers)
          }
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
