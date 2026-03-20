//
//  Untitled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/5/2025.
//

import SwiftUI

#if canImport(AppKit)

/// Important: Don't forget to provide the entry point for the modifier:
///
/// ```
/// import SwiftUI
///
/// @main
/// struct ExampleApp: App {
///
///   var body: some Scene {
///     WindowGroup {
///       ContentView()
///         .readModifierKeys() // <- Here
///     }
///   }
/// }
/// ```
public struct ModifierKeysModifier: ViewModifier {
  
  @State private var modifierKeys = Modifiers()
  
  let defaultKeys: EventModifiers = [.command, .shift, .option, .control, .capsLock]
  
  let keysToWatch: EventModifiers?
  public func body(content: Content) -> some View {
    
    if #available(macOS 15, iOS 18, *) {
      content
        .onModifierKeysChanged(mask: keysToWatch ?? defaultKeys, initial: true) { old, new in
          self.modifierKeys = Modifiers(from: new)
        }
        .environment(\.modifierKeys, modifierKeys)
      
    } else {
#if canImport(AppKit)
      content
        .onAppear {
          NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in
            self.modifierKeys = Modifiers(from: event)
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
    self.modifier(ModifierKeysModifier(keysToWatch: keysToWatch))
  }
}
#endif

//public struct ModifierKeysModifier: ViewModifier {
//
//  @State private var modifierKeys = Modifiers()
//  @State private var flagsChangedMonitor: Any?
//  @State private var scrollWheelMonitor: Any?
//
//  let defaultKeys: EventModifiers = [.command, .shift, .option, .control, .capsLock]
//
//  let keysToWatch: EventModifiers?
//  public func body(content: Content) -> some View {
//
//    let mask = keysToWatch ?? defaultKeys
//
//    let base = content
//      .onAppear { startMonitoringIfNeeded(mask: mask) }
//      .onDisappear { stopMonitoring() }
//      .environment(\.modifierKeys, modifierKeys)
//
//    if #available(macOS 15, iOS 18, *) {
//      base
//        .onModifierKeysChanged(mask: mask, initial: true) { _, new in
//          updateModifiers(Modifiers(from: new), mask: mask)
//        }
//    } else {
//      base
//    }
//
//  }
//
//  private func startMonitoringIfNeeded(mask: EventModifiers) {
//    if flagsChangedMonitor == nil {
//      flagsChangedMonitor = NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in
//        updateModifiers(Modifiers(from: event), mask: mask)
//        return event
//      }
//    }
//
//    // SwiftUI's modifier-key updates don't reliably fire during scroll/trackpad gestures.
//    // Keep the env value in sync using the modifiers attached to scroll events.
//    if scrollWheelMonitor == nil {
//      scrollWheelMonitor = NSEvent.addLocalMonitorForEvents(matching: [.scrollWheel]) { event in
//        updateModifiers(Modifiers(from: event), mask: mask)
//        return event
//      }
//    }
//  }
//
//  private func stopMonitoring() {
//    if let flagsChangedMonitor {
//      NSEvent.removeMonitor(flagsChangedMonitor)
//      self.flagsChangedMonitor = nil
//    }
//    if let scrollWheelMonitor {
//      NSEvent.removeMonitor(scrollWheelMonitor)
//      self.scrollWheelMonitor = nil
//    }
//  }
//
//  private func updateModifiers(_ modifiers: Modifiers, mask: EventModifiers) {
//    let masked = modifiers.intersection(Modifiers(from: mask))
//    guard masked != modifierKeys else { return }
//    modifierKeys = masked
//  }
//}
//
//extension View {
//  /// Falls back to default mask, if no value supplied for `keysToWatch`
//  public func readModifierKeys(_ keysToWatch: EventModifiers? = nil) -> some View {
//    self.modifier(ModifierKeysModifier(keysToWatch: keysToWatch))
//  }
//}
//#endif
