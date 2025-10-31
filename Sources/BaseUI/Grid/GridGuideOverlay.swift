//
//  GridGuideView.swift
//  SumBuddy
//
//  Created by Dave Coleman on 11/10/2025.
//

import SharedHelpers
import SwiftUI

public struct GridGuideOverlay: View {
  @Environment(\.unitSize) private var unitSize
  
  let opacity: CGFloat

  public init(opacity: CGFloat = 0.15) {
    self.opacity = opacity
  }
  public var body: some View {

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
    }  // END size check
  }
}
