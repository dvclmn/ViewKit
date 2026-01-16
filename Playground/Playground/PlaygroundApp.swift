//
//  PlaygroundApp.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import SwiftUI

@main
struct PlaygroundApp: App {
  @State private var store = AppHandler()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(store)
    }
  }
}
