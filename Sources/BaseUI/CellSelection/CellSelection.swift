//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CanvasKit
import CoreTools
import SwiftUI

struct CellSelectionTestView: View {
  @State private var store: SelectionHandler = .init()
  private let font: Font = .system(.body, design: .monospaced)
  private let documentSize: CGSize = .init(width: 500, height: 600)

  var body: some View {

    CanvasView(canvasSize: documentSize) {
      CellSelectionCanvas()
    }
    .onContinuousHover(
      coordinateSpace: .canvasIdentity
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

    .environment(\.zoomRange, 0.1...10)
    .environment(store)
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
