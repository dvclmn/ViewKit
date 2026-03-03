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
  @Environment(\.unitSize) private var unitSize
  @Environment(\.isShowingCellNumbers) private var isShowingCellNumbers

  @State private var store: SelectionHandler

  let content: Content

  public init(
    store: SelectionHandler? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self._store = State(initialValue: store ?? SelectionHandler())
    self.content = content()
  }
  public var body: some View {

    GridCanvasView {
      CellSelectionCanvas()
        .allowsCanvasClipping(false)
      content

    }
    .environment(store)

  }
}
