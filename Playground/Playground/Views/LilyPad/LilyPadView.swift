//
//  LilyPadView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import GestureKit
import LilyPad
import Sharing
import SwiftUI
import ToolKit
import VectorKit

struct LilyPadDemoView: View {
  @Environment(AppHandler.self) private var store
  @Environment(\.popup) private var popup
  @State private var pressure: String = "No pressure"
  @State private var touches: String = "No touches"

  //  @FocusState private var isFocused: Bool
  //  @State private var points: [CGPoint] = [.quickPreset01, .quickPreset02, .quickPreset03]

  var body: some View {

    @Bindable var store = store
    Color.clear
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
      )
      .overlay {
        LilyPadCanvasView()
      }
      .touches(
        isEnabled: isDrawingEnabled,
        mapStrategy: .fill,
        showIndicators: true
      ) { touches in
        handleTouches(touches)
      }

      .toolbar { ToolbarView() }

      .addInfoBarItems(LilyPadInfoItem.self, source: store, format: .short)
      .infoBarView()

      .inspector(isPresented: $store.isInspectorPresented) {
        LilyInspectorView()
      }
  }
}

extension LilyPadDemoView {

  private func handleTouches(_ touches: Set<TouchPoint>) {

    /// This currently only handles a single finger
    guard let touch = touches.first else { return }

    switch touch.phase {
      case .began:
        store.setDrawing(\.active) {
          Stroke(points: [touch.position], colour: store.strokeStyle.colour)
        }

      case .changed:
        store.setDrawing { drawing in
          drawing.active?.addPoints([touch.position])
        }

      case .ended, .cancelled:

        if let stroke = store.drawing.active {
          store.setDrawing { drawing in
            drawing.addStrokes([stroke])
            store.setDrawing(\.active, value: nil)
          }
        }

      default:
        break
    }

  }

  private var isDrawingEnabled: Bool { store.isDrawingEnabled }

}

//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var store = AppHandler()
//  LilyPadDemoView()
//    .environment(store)
//
//}
//#endif
