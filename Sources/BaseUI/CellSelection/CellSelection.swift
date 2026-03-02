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
  @Environment(\.gridCanvasSize) private var gridCanvasSize

  @State private var store: SelectionHandler

  private let zoomRange: ClosedRange<Double> = 0.1...10

  let content: Content

  public init(
    store: SelectionHandler? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self._store = State(initialValue: store ?? SelectionHandler())
    self.content = content()
  }
  public var body: some View {

    if let canvasSize = gridCanvasSize {

      CanvasView(canvasSize: canvasSize) {

        CellSelectionCanvas()
          .allowsCanvasClipping(false)
        content

      }
      .environment(\.zoomRange, zoomRange)
      .environment(\.canvasSize, canvasSize)
      .environment(store)

    } else {
      StateView("No Canvas Size")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = SelectionHandler()
  CellSelectionTestView(store: store) {
    Text("Example text")
  }
  .gridSetup(font: .sfMono, fontSize: 28, dimensions: .init(30, 14))
  //  .environment(\.gridCanvasSize, CGSize(200, 500))
  // .environment(store)
}
#endif
