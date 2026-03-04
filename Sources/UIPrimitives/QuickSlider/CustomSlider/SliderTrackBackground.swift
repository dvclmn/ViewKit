//
//  SliderTrackBackground.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

import ColourKit
import CoreTools
import SwiftUI

struct SliderTrackBackground: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.rgbComponent) private var rgbComponent
  @Environment(\.isHovering) private var isHovering
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.cornerRounding) private var cornerRounding

  let style: TrackStyle
  var body: some View {

    ZStack {
//      Rectangle()
//        .fill(
//          .checkerboard(
//            primary: RGBColour.gray(1),
//            secondary: RGBColour.gray(0.7),
//            scale: 5.5
//          )
//        )
//        .fill(style.shape())
    }
    .frame(height: store.trackHeight)
    .clipShape(clipShape)

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
