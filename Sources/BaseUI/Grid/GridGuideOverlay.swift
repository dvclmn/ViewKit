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

  private let isDrawingDebugText: Bool = false

  let opacity: CGFloat
  public func body(content: Content) -> some View {
    content
      .overlay {

        Group {
          if let unitSize {
            Canvas {
              context,
              size in

              context.drawGridLines(
                config: .init(
                  fillSize: size,
                  cellSize: unitSize,
                  colour: .cyan.opacity(opacity),
                  strokeThickness: 1
                ),
                containerSize: size,
                canvasZoom: 1.0
              )

              if isDrawingDebugText {
                debugText(
                  size: size,
                  unitSize: unitSize,
                  context: context
                )
              }
            }

          } else {
            if isPreview {
              ProgressView("Loading Unit Size")
                .foregroundStyle(.tertiary)
                .font(.caption)
            }
          }  // END size check
        }  // END group
        .allowsHitTesting(false)
      }
  }
}
extension GridGuideOverlayModifier {
  private func debugText(
    size: CGSize,
    unitSize: CGSize,
    context: GraphicsContext
  ) {
    let gridWidth: Int = size.width.toGridCount(using: unitSize.width, rounding: .up) ?? 0
    for i in 0..<gridWidth {
      context.drawDebugText(
        "\(i)",
        at: CGPoint(x: CGFloat(i) * unitSize.width, y: 0),
        positioned: .aboveOrigin,
        fontSize: 20,
        pointDisplay: .none,
        zoomPercent: 1.0
      )
    }
  }
}

extension View {

  public func gridGuide(opacity: CGFloat = 0.1) -> some View {
    self.modifier(GridGuideOverlayModifier(opacity: opacity))
  }
}
