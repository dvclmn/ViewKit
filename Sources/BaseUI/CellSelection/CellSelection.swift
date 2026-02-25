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
  @State private var store: SelectionHandler = .init()
  private let font: Font = .system(.body, design: .monospaced)
  private let documentSize: CGSize = .init(width: 500, height: 600)
  private let zoomRange: ClosedRange<Double> = 0.1...10

  public init() {}
  public var body: some View {

    CanvasView(canvasSize: documentSize) {
      CellSelectionCanvas()
    }
    
    .onContinuousHover(
      coordinateSpace: .global
        //      coordinateSpace: .local
    ) { phase in
      switch phase {
        case .active(let location): store.pointerLocation = location
        case .ended: store.pointerLocation = nil
      }
    }
    .setCharacterSize(mode: .debounce(0.2))
    .readViewportSize(mode: .debounce(0.2))
    .gridFont(.sfMono, size: 88)

    .infoBarView(debounceMode: .noDebounce)
    
    .environment(\.canvasSize, documentSize)
    .task(id: documentSize) { store.canvasSize = documentSize }
    .environment(store)
    .environment(\.zoomRange, zoomRange)
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
