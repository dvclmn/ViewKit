//
//  TrackFillView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

import ColourKit
import SwiftUI

struct SliderTrackView: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.rgbComponent) private var rgbComponent
  @Environment(\.isHovering) private var isHovering

//  let style: TrackFillStyle
  let style: TrackStyle
  let height: Double
  let midpoint: CGPoint
  
  var body: some View {

    ZStack {
      Rectangle()
        .fill(style.background)
        .fill(style.foreground)
    }
    .drawingGroup()
    .frame(height: height)

    .overlay(alignment: .leading) {
      if let width = store.fillWidth() {
        Rectangle()
          .fill(style.fill.opacity(isHovering ? 1.0 : 0.6))
          .frame(width: width)
      }
    }
    .clipShape(clipShape)
    .animation(Styles.animationExtraQuickNSmooth, value: isHovering)
    .position(midpoint)
//    .position(size.midpoint)

  }
}

//extension ExampleView {
//
//}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  // @Previewable @State var store = AppHandler()
//  ExampleView()
//  // .environment(store)
//}
//#endif
