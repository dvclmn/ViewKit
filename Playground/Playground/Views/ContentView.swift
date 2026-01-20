//
//  ContentView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

internal import ColourKit
import GraphicsKit
import LilyPad
import SwiftUI
import ToolKit
import VectorKit

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
      store.setPref(\.tab, value: .lilypad)

      //      guard
      //        let artwork = try? ImportHandler.loadData(
      //          named: "lilypadDrawing02",
      //          withExtension: "json",
      //          asType: DrawingData.self
      //        )
      //      else {
      //        print("Couldn't load test data")
      //        return
      //      }
      //
      //      store.setDrawing(\.self, value: artwork)
      store.strokeStyle.style = .stamped(shape: .circle, radius: 3.0)

    }
}
#endif
