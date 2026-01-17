//
//  LilyPadView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import GestureKit
import SwiftUI
import ToolKit

struct LilyPadDemoView: View {
  @Environment(AppHandler.self) private var store
  @State private var pressure: String = "No pressure"
  @State private var touches: String = "No touches"

  //  @FocusState private var isFocused: Bool
  //  @State private var points: [CGPoint] = [.quickPreset01, .quickPreset02, .quickPreset03]

  var body: some View {

    @Bindable var store = store
    Text("Is drawing enabled? \(isDrawingEnabled.description)")
      .padding(40)
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
      )
      //      .frame(width: 600, height: 700)
      .overlay {
        Canvas { context, size in
          //        Canvas(rendersAsynchronously: false) { context, size in
          var path = Path()
          let pts = points
          //          let pts = points(every: 2)
          if let first = pts.first {
            path.move(to: first)
            for pt in pts.dropFirst() {
              path.addLine(to: pt)
            }
          }
          context.stroke(path, with: .color(.blue), lineWidth: 3)
        }
      }
      .touches(
//        isEnabled: true,
                isEnabled: isDrawingEnabled,
        mapStrategy: .fill,
        showIndicators: true
      ) { touches in

//        store.setDrawing(\.points) {
//          $0.append(touches.map(\.position))
//        }
        if let current = touches.first {
//          print("Got current: \(current.position)")
          store.setDrawing(\.points) {
            $0.append(current.position)
          }
        } else {
//          print("No thing")
        }

      }
      //      .printInfo(.applicationSupport)
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
            store.setDrawing(\.points, value: [])
          }
          .keyboardShortcut(.delete, modifiers: [])
        }
        ToolbarItem {
          Toggle("Toggle Drawing", isOn: $store.isDrawingEnabled)
        }
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

  private var isDrawingEnabled: Bool { store.isDrawingEnabled }

  private var points: [CGPoint] { store.drawing.points }
  private func points(every n: Int = 2) -> [CGPoint] {
    let points = store.drawing.points
    let strideIndices = stride(from: 0, to: points.count, by: n)
    return strideIndices.map { points[$0] }
  }

}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyPadDemoView()
    .environment(store)
}
#endif
