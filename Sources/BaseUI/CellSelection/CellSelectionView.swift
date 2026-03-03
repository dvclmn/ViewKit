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

public struct CellSelectionView<Content: View>: View {
  //  @Environment(\.gridCanvasSize) private var gridCanvasSize
  @Environment(\.unitSize) private var unitSize
  @Environment(\.isShowingCellNumbers) private var isShowingCellNumbers

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

    //    if let gridCanvasSize {

    GridCanvasView {
      //      CanvasView(canvasSize: gridCanvasSize.cgSize) {

      CellSelectionCanvas()
        .allowsCanvasClipping(false)

      content
        .padding(.top, offset.top)
        .padding(.leading, offset.leading)

    }
    .environment(\.zoomRange, zoomRange)
    /// Don't add canvas size to Env, CanvasView already does this
    //      .environment(\.canvasSize, gridCanvasSize)
    .environment(store)

    //    } else {
    //      StateView("Missing Canvas Size", message: "No value found for `gridCanvasSize` in the Environment")
    //        .frame(maxWidth: .infinity, maxHeight: .infinity)
    //    }
  }
}

extension CellSelectionView {
  /// Offset to accomodate row/col numbers, if present
  private var offset: (top: CGFloat, leading: CGFloat) {
    guard let unitSize else { return (0, 0) }
    return isShowingCellNumbers
      ? (unitSize.height, unitSize.width)
      : (0, 0)
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = SelectionHandler()
  CellSelectionView(store: store) {
    Text("Example text")
  }
  .gridSetup(font: .sfMono, fontSize: 28, dimensions: .init(30, 14))
  //  .environment(\.gridCanvasSize, CGSize(200, 500))
  // .environment(store)
}
#endif
