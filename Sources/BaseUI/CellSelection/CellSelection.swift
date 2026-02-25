//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CanvasKit
import SwiftUI

struct CellSelectionTestView: View {

  private let font: Font = .system(.body, design: .monospaced)
  private let documentSize: CGSize = .init(width: 500, height: 600)

  var body: some View {

    CanvasView(canvasSize: documentSize) {
      CellSelectionCanvas()
    }
    .setCharacterSize(mode: .debounce(0.2))

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
