//
//  GridGuideView.swift
//  SumBuddy
//
//  Created by Dave Coleman on 11/10/2025.
//

import StringShared
import SwiftUI

public struct GridGuideOverlayModifier: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  let opacity: CGFloat
  public func body(content: Content) -> some View {
    content
      .overlay {

        if let unitSize {
          Canvas {
            context,
            size in

            context.drawGridLines(
              config: .init(
                fillSize: size,
                cellSize: unitSize,
                colour: .cyan,
                strokeThickness: 1
              ),
              containerSize: size,
              canvasZoom: 1.0
            )

            let gridWidth: Int = size.width.toGridCount(using: unitSize.width, rounding: .up) ?? 0
            for i in 0..<gridWidth {
              context.drawDebugText(
                "\(i)",
                at: CGPoint(x: CGFloat(i) * unitSize.width, y: 0),
                pointDisplay: .point(.blue),
                zoomPercent: 1.0
              )

            }
          }
          //      .compositingGroup()
          .opacity(opacity)
          .allowsHitTesting(false)

        } else {
          if isPreview {
            ProgressView("Loading Unit Size")
              .foregroundStyle(.tertiary)
              .font(.caption)
            //            Text("Unit Size not found")
            //              .foregroundStyle(.red.secondary)
            //              .bold()
            //              .background(Color.black)
          }
        }  // END size check

        //        GridGuideOverlay(opacity: opacity)
      }
  }
}

extension View {
  public func gridGuide(opacity: CGFloat = 0.1) -> some View {
    self.modifier(GridGuideOverlayModifier(opacity: opacity))
  }
}
