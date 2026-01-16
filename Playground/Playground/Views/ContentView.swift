//
//  ContentView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import SwiftUI
import ToolKit

enum PlaygroundTab: String, LabeledItem, CaseIterable, Hashable {
  case home
  case lilypad
}

struct ContentView: View {
  @State private var tab: PlaygroundTab = .lilypad
  var body: some View {
    QuickTabView(tab: $tab) { tab in
      switch tab {
        case .home: Text("Home")
        case .lilypad: LilyPadDemoView()
      }
    }
  }
}

#Preview {
  ContentView()
}
