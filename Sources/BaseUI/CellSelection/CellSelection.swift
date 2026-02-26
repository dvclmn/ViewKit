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

public struct CellSelectionTestView: View {
  @Environment(\.gridDimensions) private var gridDimensions
  @Environment(\.viewportRect) private var viewportRect
  @Environment(\.unitSize) private var unitSize
  @Environment(\.gridCanvasSize) private var gridCanvasSize

  @State private var store: SelectionHandler = .init()

  //  private let font: Font = .system(.body, design: .monospaced)
  private let zoomRange: ClosedRange<Double> = 0.1...10

  public init() {}
  public var body: some View {

    if let canvasSize = gridCanvasSize {

      CanvasView(canvasSize: canvasSize) {
        CellSelectionCanvas()
      }

      .onContinuousHover(coordinateSpace: .global) { phase in
        switch phase {
          case .active(let location): store.pointerLocation = location
          case .ended: store.pointerLocation = nil
        }
      }
      //      .setCharacterSize(mode: .debounce(0.2))
      //      .viewportCapture(mode: .debounce(0.2))

      .infoBarView(debounceMode: .debounce(0.1))

      .task(id: canvasSize) { store.canvasSize = canvasSize }
      .task(id: gridDimensions) { store.gridDimensions = gridDimensions }

      .environment(\.zoomRange, zoomRange)
      .environment(\.canvasSize, canvasSize)
      .environment(store)

      .overlay(alignment: .topLeading) {
        if let viewportRect {
          Rectangle()
            .fill(.brown.tertiary)
            .stroke(.orange.secondary, lineWidth: 1)
            .frame(
              width: viewportRect.width,
              height: viewportRect.height,
              alignment: .topLeading
            )
            .offset(
              x: viewportRect.origin.x,
              y: viewportRect.origin.y
            )
            .allowsHitTesting(false)
        }
      }

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
