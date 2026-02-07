//
//  SliderTrackBackground.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

import ColourKit
import SwiftUI
import CoreTools

struct SliderTrackBackground: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.rgbComponent) private var rgbComponent
  @Environment(\.isHovering) private var isHovering
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.cornerRounding) private var cornerRounding

  //  let style: TrackFillStyle
  let style: TrackStyle
  let height: Double
//  let midpoint: CGPoint

  var body: some View {

    ZStack {
      Rectangle()
        .fill(style.shape())
      //        .fill(style.foreground)
    }
//    .drawingGroup()
    .frame(height: height)

    //    .overlay(alignment: .leading) {
    //      if let width = store.fillWidth() {
    //        Rectangle()
    //          .fill(style.fill.opacity(isHovering ? 1.0 : 0.6))
    //          .frame(width: width)
    //      }
    //    }
    .clipShape(clipShape)
//    .animation(Styles.animationExtraQuickNSmooth, value: isHovering)
//    .position(midpoint)
    //    .position(size.midpoint)

  }
}

extension SliderTrackBackground {
  var clipShape: AnyShape {
    switch sliderComponents {

      /// Aka has fill *only*
      case .track: AnyShape(.rect(cornerRadius: cornerRounding ?? Styles.sizeTiny))
      default: AnyShape(.capsule)
    }
  }
}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  // @Previewable @State var store = AppHandler()
//  ExampleView()
//  // .environment(store)
//}
//#endif
