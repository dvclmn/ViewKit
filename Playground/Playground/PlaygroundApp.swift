//
//  PlaygroundApp.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import SwiftUI
import ToolKit

@main
struct PlaygroundApp: App {
  @State private var store = AppHandler()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(store)
        .readModifierKeys()
//        .readViewportSize(mode: .debounce(0.2))
    }
    .commands {
      CommandGroup(after: .newItem) {
        Toggle("Toggle Drawing", isOn: $store.isDrawingEnabled)
          .keyboardShortcut("a", modifiers: .shift)
      }
    }
  }
}
