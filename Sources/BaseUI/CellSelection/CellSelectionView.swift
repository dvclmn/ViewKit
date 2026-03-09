//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import CanvasKit
import LayoutKit
import SwiftUI

public struct CellSelectionView<Content: View>: View {

  let content: Content

  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }
  public var body: some View {

    GridCanvasView {
      CellSelectionCanvas()
        .allowsCanvasClipping(false)

      content
      //        .debugFrame("Canvas Content", .mint)
    }
    .environment(\.shouldShowInfoBarItems, true)

  }
}
