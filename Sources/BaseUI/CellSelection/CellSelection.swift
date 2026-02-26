//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CanvasKit
import CoreTools
import SwiftUI

public struct CellSelectionTestView: View {
  @Environment(\.canvasSize) private var canvasSize
  @Environment(\.gridDimensions) private var gridDimensions
  @State private var store: SelectionHandler = .init()
  private let font: Font = .system(.body, design: .monospaced)
  private let zoomRange: ClosedRange<Double> = 0.1...10

  public init() {}
  public var body: some View {

    if let canvasSize {

      CanvasView(canvasSize: canvasSize) {
        CellSelectionCanvas()
      }

      .onContinuousHover(coordinateSpace: .local) { phase in
        switch phase {
          case .active(let location): store.pointerLocation = location
          case .ended: store.pointerLocation = nil
        }
      }
      .setCharacterSize(mode: .debounce(0.2))
      .viewportCapture(mode: .debounce(0.2))
      .gridFont(.sfMono, size: 88)
      .infoBarView(debounceMode: .debounce(0.1))

      .task(id: canvasSize) { store.canvasSize = canvasSize }
      .task(id: gridDimensions) { store.gridDimensions = gridDimensions }

      .environment(store)
      .environment(\.zoomRange, zoomRange)
      
    } else {
      StateView("No Canvas Size")
    }
    //    .environment(\.canvasSize, documentSize)
  }
}

extension CellSelectionTestView {

}
#if DEBUG
#Preview {

  CellSelectionTestView()
    .frame(width: 600, height: 700)

}
#endif
