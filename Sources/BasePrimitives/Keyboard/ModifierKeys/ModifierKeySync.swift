//
//  ModifierKeySync.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

import SwiftUI

private struct ModifierKeySyncModifier: ViewModifier {
  @Environment(\.modifierKeys) private var modifierKeys
  let apply: (Modifiers) -> Void

  func body(content: Content) -> some View {
    content
      .task(id: modifierKeys) { apply(modifierKeys) }
    //      .onChange(of: modifierKeys) { _, newValue in apply(newValue) }
  }
}

extension View {

  /// ## Custom closure
  ///
  /// ```
  /// SomeView()
  ///   .syncModifiers { newKeys in
  ///     myStore.updateKeys(newKeys)
  ///   }
  /// ```
  public func syncModifiers(apply: @escaping (Modifiers) -> Void) -> some View {
    self.modifier(ModifierKeySyncModifier(apply: apply))
  }

  /// ## Binding
  /// ```
  /// @State private var modifiers = Modifiers()
  /// SomeView()
  ///   .syncModifiers(to: $modifiers)
  /// ```
  public func syncModifiers(to binding: Binding<Modifiers>) -> some View {
    syncModifiers { binding.wrappedValue = $0 }
  }

  /// ## Reference type (e.g., CanvasInteractionState)
  ///
  /// ```
  /// @State private var interactionState = CanvasInteractionState()
  /// SomeView()
  ///   .syncModifiers(to: interactionState, keyPath: \.modifiers)
  /// ```
  //  func syncModifiers<Object: AnyObject>(to object: Object, keyPath: ReferenceWritableKeyPath<Object, Modifiers>) -> some View {
  //    syncModifiers { [weak object] in object?[keyPath: keyPath] = $0 }
  //  }
}
