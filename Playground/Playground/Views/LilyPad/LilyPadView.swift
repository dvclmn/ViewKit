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

struct LilyPadDemoView: View {
  @Environment(AppHandler.self) private var store
  @Environment(\.popup) private var popup
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

          var path = Path()
          var pathActive = Path()

          /// Draw completed strokes
          for stroke in store.drawing.strokes {
            guard let first = stroke.points.first else { continue }
            path.move(to: first)
            for pt in stroke.points.dropFirst() {
              path.addLine(to: pt)
            }
          }

          /// Draw active stroke (if any)
          if let active = store.activeStroke, let first = active.points.first {
            pathActive.move(to: first)
            for pt in active.points.dropFirst() {
              pathActive.addLine(to: pt)
            }
          }

          context.stroke(path, with: .color(.brown), lineWidth: 3)
          context.stroke(pathActive, with: .color(.purple), lineWidth: 3)

          //          //        Canvas(rendersAsynchronously: false) { context, size in
          //          var path = Path()
          //          /// IMPORTANT: This is flatmpaiing for now, but will need to
          //          /// handle sep. strokes later
          //          let pts = strokes.flatMap(\.points)
          //          //          let pts = points(every: 2)
          //          if let first = pts.first {
          //            path.move(to: first)
          //            for pt in pts.dropFirst() {
          //              path.addLine(to: pt)
          //            }
          //          }
          //          context.stroke(path, with: .color(.blue), lineWidth: 3)
        }
      }
      .touches(
        //        isEnabled: true,
        isEnabled: isDrawingEnabled,
        mapStrategy: .fill,
        showIndicators: true
      ) { touches in

        // Typically you'll filter to a single touch for drawing
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
  private var strokes: [Stroke] { store.drawing.strokes.toArray }

  //  private var points: [CGPoint] { store.drawing.points }
  //  private func points(every n: Int = 2) -> [CGPoint] {
  //    let points = store.drawing.points
  //    let strideIndices = stride(from: 0, to: points.count, by: n)
  //    return strideIndices.map { points[$0] }
  //  }

}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyPadDemoView()
    .environment(store)
    .onAppear {
      guard let artwork = try? ImportHandler.loadData(
        named: "lilypadDrawing",
        withExtension: "json",
        asType: DrawingData.self
      ) else {
        print("Couldn't load test data")
        return
      }
      
      store.setDrawing(\.self, value: artwork)
      
    }
}
#endif
