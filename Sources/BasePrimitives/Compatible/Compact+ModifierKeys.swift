//
//  Compact+Modifiers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

public struct ModifiersChanged_CompatibleModifier: ViewModifier {

  let mask: EventModifiers
  let action: (_ old: EventModifiers, _ new: EventModifiers) -> Void
  public func body(content: Content) -> some View {

    if #available(macOS 15, *) {
      content
        .onModifierKeysChanged(mask: mask, initial: true, action)
    } else {
      content
    }

  }
}
extension View {
  public func onModifierKeysChangedCompatible(
    mask: EventModifiers,
    action: @escaping (_ old: EventModifiers, _ new: EventModifiers) -> Void
  ) -> some View {
    self.modifier(
      ModifiersChanged_CompatibleModifier(
        mask: mask,
        action: action
      )
    )
  }
}
