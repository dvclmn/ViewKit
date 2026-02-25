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
  private let documentSize: CGSize = .init(width: 1000, height: 800)
  // @Environment(AppHandler.self) private var store
  // @Environment(\.viewportSize) private var viewportSize

  var body: some View {

    CanvasView(canvasSize: documentSize) {
      Text("Test")
        .characterSize(
          mode: .debounce(0.2),
          shouldSetEnv: true
        )
    }

  }
}

extension CellSelectionTestView {

}
#if DEBUG
#Preview {
  // @Previewable @State var store = AppHandler()
  CellSelectionTestView()
    .frame(width: 600, height: 700)
  // .environment(store)
}
#endif
