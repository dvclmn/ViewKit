//
//  CellSelectionCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import GraphicsKit
import SwiftUI

struct CellSelectionCanvas: View {
  @Environment(SelectionHandler.self) private var store
  @Environment(\.unitSize) private var unitSize
  @Environment(\.zoomLevel) private var zoomLevel
  @Environment(\.zoomRange) private var zoomRange

  var body: some View {

    Canvas(
      opaque: true,
      rendersAsynchronously: true
    ) {
      context,
      size in

      context.drawGrid(
        in: size,
        mode: .fillContainer,
        lineColour: .gray.opacity(0.3),
        lineWidth: 1,
        annotations: .quarter,
        drawsBorder: false
      )
    }  // END canvas

    .addInfoBarItems {
      Labeled("Pointer", value: store.pointerLocation?.displayString(.location))
      Labeled("Cell Size", value: unitSize?.displayString(.dimensions))
      Labeled("Zoom", value: zoomLevel.toPercentString(within: zoomRange ?? .unitRange))
    }
  }
}
