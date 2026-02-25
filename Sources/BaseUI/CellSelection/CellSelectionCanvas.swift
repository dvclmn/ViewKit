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
  @Environment(\.unitSize) private var unitSize

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
        lineColour: .gray.opacity(0.2),
        lineWidth: 1,
        annotations: .half
      )
//      let gridConfig: GridConfiguration = .init(
//        fillStyle: .fixed(columns: 10, rows: 20),
////        fillStyle: .fill(size: size),
//        colour: .gray.opacity(0.1),
//        lineWidth: 1,
//        density: .half
//      )
//
//      context.drawGrid(
//        config: gridConfig,
//        containerSize: size,
//        isInfinite: false
//      )

    }

  }
}
