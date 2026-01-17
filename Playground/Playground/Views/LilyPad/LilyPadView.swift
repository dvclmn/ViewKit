//
//  LilyPadView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import GestureKit
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
    Color.black.opacity(0.8)
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
      )
      .overlay {
        LilyPadCanvasView(activeStroke: store.activeStroke, strokes: store.drawing.strokes)
      }
      .touches(
        //        isEnabled: true,
        isEnabled: isDrawingEnabled,
        mapStrategy: .fill,
        showIndicators: true
      ) { touches in
        handleTouches(touches)
      } didUpdatePressure: { pressure in
        store.pressure = pressure
      }
      .printInfo(.applicationSupport)
      //      .focusable()
      //      .focused($isFocused)
      //      .onExitCommand {
      //        print("Pressed Esc, drawing mode turned off")
      //        store.isDrawingEnabled = false
      //      }

      //      .debugTextOverlay(pressure, touches)
      .toolbar {
        ToolbarItem {
          Button("Clear") {
            store.setDrawing(\.strokes, value: [])
          }
          .keyboardShortcut(.delete, modifiers: [])
        }
        ToolbarItem {
          Toggle("Toggle Drawing", isOn: $store.isDrawingEnabled)
        }
      }

      .addInfoBarItems(LilyPadInfoItem.self, source: store, format: .short)
      .infoBarView()
      .environment(\.strokeDensity, store.strokeDensity)

      .inspector(isPresented: $store.isInspectorPresented) {
        LilyInspectorView()
      }
    //      .background(isDrawingEnabled ? )
    //      .task(id: isDrawingEnabled) {
    //        if isDrawingEnabled {
    //          self.isFocused = true
    //        } else {
    //          self.isFocused = false
    //        }
    //      }
    //      .debugTextOverlay("View focused", isEnabled: isFocused)
  }
}

extension LilyPadDemoView {
  private func handleTouches(_ touches: Set<TouchPoint>) {
    guard let touch = touches.first else { return }

    switch touch.phase {

      case .began:
        store.activeStroke = ActiveStroke(
          id: UUID(),
          points: [touch.position]
        )

      case .changed:
        store.activeStroke?.points.append(touch.position)

      case .ended, .cancelled:
        if let stroke = store.activeStroke {
          store.$drawing.withLock {
            $0.strokes.append(Stroke(id: stroke.id, points: stroke.points))
          }
          store.activeStroke = nil
        }

      default:
        break
    }

    //        store.setDrawing(\.points) {
    //          $0.append(touches.map(\.position))
    //        }
    //        let points: [CGPoint]
    //        if let current = touches.first {
    //          print("Got current: \(current.position)")
    //          store.setDrawing(\.strokes) {
    //            $0.insert(Stroke(points: current.position))
    //          }

    //        } else {
    //          print("No thing")
    //        }

  }

  private var isDrawingEnabled: Bool { store.isDrawingEnabled }

}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyPadDemoView()
    .environment(store)
    .onAppear {
      guard
        let artwork = try? ImportHandler.loadData(
          named: "lilypadDrawing",
          withExtension: "json",
          asType: DrawingData.self
        )
      else {
        print("Couldn't load test data")
        return
      }

      store.setDrawing(\.self, value: artwork)

    }
}
#endif
