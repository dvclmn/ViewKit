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
    @Environment(SelectionHandler.self) private var store
    @Environment(\.unitSize) private var unitSize

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
      self.content = content
    }
    public var body: some View {
      
      @Bindable var store = store

      GridCanvasView {
        CellSelectionCanvas()
          .allowsCanvasClipping(false)

//          .onGridDrag { origin, end in
//            <#code#>
//          }
          .onGridTap { position in
            store.handleSelection([position])
            //            store.selected.insert(position)

            print("Tapped cell: \(position)")
          }

        content()
      }

      .debugTextOverlay(alignment: .bottomLeading) {
//        Labeled("Selected", value: store.selected.map(\.description).joined(separator: ", "))
      }

      .environment(\.shouldShowInfoBarItems, true)

      .syncModifiers(to: $store.modifiers)
      .task(id: unitSize) { store.updateCellSize(unitSize) }
    }
  }
}
