//
//  ContentView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import SwiftUI
import ToolKit
import VectorKit

enum PlaygroundTab: String, LabeledItem, CaseIterable, Hashable {
  case home
  case lilypad
}

struct ContentView: View {
  @Environment(AppHandler.self) private var store
  @State private var tab: PlaygroundTab = .lilypad
  var body: some View {
    @Bindable var store = store
    QuickTabView(tab: $tab) { tab in
      switch tab {
        case .home: Text("Home")
        case .lilypad: LilyPadDemoView()
      }
    }
    
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  ContentView()
    .environment(store)
}
#endif
