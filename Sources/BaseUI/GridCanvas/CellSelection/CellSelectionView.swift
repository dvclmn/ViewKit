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

extension GridCanvas {
  public struct CellSelectionView<Content: View>: View {
      @State private var store: SelectionHandler<Grid> = .init()

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
      self.content = content
    }
    public var body: some View {

      GridCanvasView {
        CellSelectionCanvas()
          .allowsCanvasClipping(false)

          .onGridTap { position in
            
            store.selected.insert(position)
//            let tappedPosition
            print("Tapped cell: \(position)")
          }

        content()
      }
      .environment(\.shouldShowInfoBarItems, true)
    }
  }
}
