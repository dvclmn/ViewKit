//
//  Untitled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/5/2025.
//

import SwiftUI

#if canImport(AppKit)
public struct ModifierKeysModifier: ViewModifier {

  @State private var modifierKeys = Modifiers()

  let keysToWatch: EventModifiers?
  public func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *) {
      content
        .onModifierKeysChanged(mask: keysToWatch ?? .defaultKeys, initial: true) { old, new in
          self.modifierKeys = Modifiers(from: new)
        }
        .environment(\.modifierKeys, modifierKeys)
      //        .task(id: modifierKeys) {
      //          print("Modifier keys changed: \(modifierKeys.description)")
      //        }

    } else {
      #if canImport(AppKit)
      content
        .onAppear {
          NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in
            self.modifierKeys = Modifiers(from: event.modifierFlags)
            return event
          }
        }
        .environment(\.modifierKeys, modifierKeys)
      #else
      content
      #endif
    }

  }
}

extension View {
  /// Falls back to default mask, if no value supplied for `keysToWatch`
  public func readModifierKeys(_ keysToWatch: EventModifiers? = nil) -> some View {
//    #if canImport(AppKit)
    self.modifier(ModifierKeysModifier(keysToWatch: keysToWatch))
//    #elseif canImport(UIKit)
//    self
//    #endif
  }
}
#endif
