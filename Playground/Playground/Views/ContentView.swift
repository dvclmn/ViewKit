//
//  ContentView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import SwiftUI
import ToolKit
import VectorKit

enum PlaygroundTab: String, LabeledItem, CaseIterable, Hashable, Codable {
  case home
  case lilypad
  case sliders
}

struct ContentView: View {
  @Environment(AppHandler.self) private var store
  
  var body: some View {
    @Bindable var store = store
    QuickTabView(tab: store.prefBinding(\.tab)) { tab in
      switch tab {
        case .home: Text("Home")
        case .lilypad: LilyPadDemoView()
        case .sliders: SlidersDemoView()
      }
    }
    .background(Color.black.opacity(0.7))

  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  ContentView()
    .environment(store)
    .onAppear {
      store.setPref(\.tab, value: .sliders)
    }
}
#endif
