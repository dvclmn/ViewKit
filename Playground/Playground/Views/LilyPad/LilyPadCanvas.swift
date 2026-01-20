//
//  LilyPadCanvas.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import ColourKit
import CoreTools
import GraphicsKit
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

      for stroke in store.drawing.strokes.keys {

        if let config = store.drawing.strokes[stroke] {
          stroke
            //          .rawPoints
            .sampledPoints(every: stride)
            .processPath(
              type: config.style,
              //          type: store.pathStyle.toPathStyle,
              path: &path
            )

          let colour = config.colour.toColour
          let lineWidth = config.lineWidth

//          DebugString {
//            Labeled("Colour", value: colour)
//            Labeled("Line width", value: lineWidth)
//          }

          context.stroke(path, with: .color(colour), lineWidth: lineWidth)

        }

        //        context.withCGContext { ctx in
        //          let col = stroke.value.colour.toCGColour(in: context.environment)
        //          //          let cgc: CGColor = stroke.value.colour.toColour.resolve(in: context.environment)
        //          ctx.setStrokeColor(col ?? CGColor.white)
        //
        //          ctx.strokePath()
        //        }
      }

      if let active = store.drawing.active {
        active
          .sampledPoints(every: stride)
          .processPath(type: store.strokeStyle.style, path: &pathActive)
        context.stroke(pathActive, with: .color(store.strokeStyle.colour.toColour), lineWidth: store.strokeStyle.lineWidth)
      }

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

      //      let lineWidth = 3.0
      //          let lineWidth = store.pressure * 3
      //      context.stroke(path, with: .color(.brown), lineWidth: lineWidth)
      //      context.stroke(path, with: .color(.brown), lineWidth: lineWidth)

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
