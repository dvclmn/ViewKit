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
  @Environment(\.pointerGridPosition) private var pointerGridPosition
  @Environment(\.pointerLocation) private var pointerLocation
  @Environment(\.viewportRect) private var viewportRect
  @Environment(\.gridGeometry) private var gridGeometry
  @Environment(\.zoomLevel) private var zoomLevel

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

    //    .addInfoBarItems {
    //      Labeled("Hover", value: pointerGridPosition)
    //      //      Labeled("Hover", value: store.pointerLocation)
    //    }

    .overlay(alignment: .bottomTrailing) {
      VStack(alignment: .leading) {
        Text(
          DisplayString {
            Labeled("Viewport rect", value: viewportRect?.debugDescription)
            Labeled("Grid Geometry", value: gridGeometry?.description)
            Labeled("Pointer Location", value: pointerLocation?.displayString(.concise))
            Labeled("Zoom", value: zoomLevel)
          }.text
        )
        .font(.callout)
        .quickRoundedBackground()
        .padding()
      }
      //      .offset(y: 50)
    }
  }
}
