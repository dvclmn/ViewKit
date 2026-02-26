//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CanvasKit
import CoreTools
import LayoutKit
import SwiftUI

public struct CellSelectionTestView<Content: View>: View {
  @Environment(\.gridDimensions) private var gridDimensions
  @Environment(\.viewportRect) private var viewportRect
  @Environment(\.unitSize) private var unitSize
  @Environment(\.gridCanvasSize) private var gridCanvasSize

  @State private var store: SelectionHandler = .init()

  private let zoomRange: ClosedRange<Double> = 0.1...10

  let content: Content

  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content()
  }
  public var body: some View {

    if let canvasSize = gridCanvasSize {

      CanvasView(canvasSize: canvasSize) {
        ZStack {
          CellSelectionCanvas()
          content
        }
      }

      .onContinuousHover(coordinateSpace: .global) { phase in
        switch phase {
          case .active(let location): store.pointerLocation = location
          case .ended: store.pointerLocation = nil
        }
      }
      //      .setCharacterSize(mode: .debounce(0.2))
      //      .viewportCapture(mode: .debounce(0.2))

      .task(id: canvasSize) { store.canvasSize = canvasSize }
      .task(id: gridDimensions) { store.gridDimensions = gridDimensions }

      .environment(\.zoomRange, zoomRange)
      .environment(\.canvasSize, canvasSize)
      .environment(store)

    } else {
      StateView("No Canvas Size")
    }
    //    .environment(\.canvasSize, documentSize)
  }
}

//extension CellSelectionTestView {
//
//}
//#if DEBUG
//#Preview {
//
//  GridGeometryView(dimensions: .) {
//    CellSelectionTestView()
//
//  }
//  .frame(width: 600, height: 700)
//
//}
//#endif
