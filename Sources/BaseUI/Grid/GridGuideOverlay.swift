//
//  GridGuideView.swift
//  SumBuddy
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI
import SharedHelpers

public struct GridGuideOverlay: View {
  @Environment(\.unitSize) private var unitSize
  //  @Environment(\.isDebugMode) private var isDebugMode
  let opacity: CGFloat

  public init(opacity: CGFloat = 0.15) {
    self.opacity = opacity
  }
  public var body: some View {

    if let unitSize {

      Canvas {
        context,
        size in
        //        let gridCell = Path(fromSize: charSize)
        context.drawGridLines(
          config: .init(
            fillSize: size,
            //            columnCount: 10,
            //            rowCount: 12,
            cellSize: unitSize,
            colour: .cyan,
            strokeThickness: 1
          ),
          containerSize: size,
          canvasZoom: 1.0
        )
      }
      .compositingGroup()
      .opacity(opacity)
      //      .opacity(store.gridBackgroundOpacity)
      .allowsHitTesting(false)
    }  // END size check
  }
}
