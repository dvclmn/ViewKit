//
//  LilyPadCanvas.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import LilyPad
import SwiftUI
import VectorKit

struct LilyPadCanvasView: View {
  @Environment(AppHandler.self) private var store

  //  let activeStroke: Stroke?
  //  let strokes: [Stroke]
  var body: some View {

    Canvas {
      context,
      size in

      let stride = context.environment.strokeDensity

      var path = Path()
      var pathActive = Path()

      for stroke in store.drawing.strokes {
        stroke.key
          //          .rawPoints
          .sampledPoints(every: stride)
          .processPath(
            type: stroke.value.style,
            //          type: store.pathStyle.toPathStyle,
            path: &path
          )
      }

      //      if let active = store.drawing.active {
      //        active
      //          .sampledPoints(every: stride)
      //          .processPath(type: store.strokeStyle.style, path: &pathActive)
      //      }

      //          path.addDot(at: <#T##CGPoint#>, radius: <#T##CGFloat#>, using: <#T##DebugPathElement#>)

      //          for stroke in strokes {
      //            let pts = stroke.sampledPoints(every: stride)
      //            guard let first = pts.first else { continue }
      //
      //            path.move(to: first)
      //            for pt in pts.dropFirst() {
      //              path.addLine(to: pt)
      //            }
      //          }
      //
      //          if let active = activeStroke {
      //            let pts = active.sampledPoints(every: stride)
      //            if let first = pts.first {
      //              pathActive.move(to: first)
      //              for pt in pts.dropFirst() {
      //                pathActive.addLine(to: pt)
      //              }
      //            }
      //          }

      let lineWidth = 3.0
      //          let lineWidth = store.pressure * 3
      context.stroke(path, with: .color(.brown), lineWidth: lineWidth)
      context.stroke(pathActive, with: .color(.purple), lineWidth: lineWidth)

    }

  }
}

extension LilyPadCanvasView {

}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var store = AppHandler()
//  ExampleView()
//    .environment(store)
//}
//#endif
