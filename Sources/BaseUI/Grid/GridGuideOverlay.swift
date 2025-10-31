//
//  GridGuideView.swift
//  SumBuddy
//
//  Created by Dave Coleman on 11/10/2025.
//

import SharedHelpers
import SwiftUI

//public struct GridGuideOverlay: View {
//
//
//  let opacity: CGFloat
//
//  public init(opacity: CGFloat = 0.15) {
//    self.opacity = opacity
//  }
//  public var body: some View {
//
//  }
//}

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
          }
          //      .compositingGroup()
          .opacity(opacity)
          .allowsHitTesting(false)
        } else {
          Text("Unit Size not found")
            .foregroundStyle(.red.secondary)
            .bold()
            .background(Color.black)
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
