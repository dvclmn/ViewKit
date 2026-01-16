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

  @State private var points: [CGPoint] = [.quickPreset01, .quickPreset02, .quickPreset03]

  var body: some View {

    Text("Hello")
      .padding(40)
      .frame(width: 600, height: 700)
      .overlay {
        Canvas { context, size in
          var path = Path()
          if let first = points.first {
            path.move(to: first)
            for pt in points.dropFirst() {
              path.addLine(to: pt)
            }
          }
          context.stroke(path, with: .color(.blue), lineWidth: 3)
        }
        //        Canvas(
        //          rendersAsynchronously: true) { context, size in
        //              let path = Path { p in
        //                for stroke in drawing {
        //                p.move(to: stroke.position)
        //                p.
        //              }
        //            }
        //            context.stroke(path, with: <#T##GraphicsContext.Shading#>, lineWidth: <#T##CGFloat#>)
        //          }
      }
      .touches(
        isEnabled: true,
        mapStrategy: .fill,
        showIndicators: true
      ) { touches in

        if let current = touches.first {
          points.append(current.position)
        }
        //        self.touches = touches.reduce(
        //          into: "",
        //          { partialResult, point in
        //            partialResult +=
        //              DisplayString {
        //                Labeled("Position", value: point.position.displayString)
        //                Labeled("Velocity", value: point.velocity.displayString)
        //                Labeled("Magnitude", value: point.magnitude.displayString)
        //              }.text
        //          })
      } didUpdatePressure: { pressure in
        self.pressure = pressure.displayString
      }

//      .debugTextOverlay(pressure, touches)
  }
}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyPadDemoView()
    .environment(store)
}
#endif
