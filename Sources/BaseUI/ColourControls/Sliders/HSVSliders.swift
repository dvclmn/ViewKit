//
//  HSVSliders.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/7/2026.
//

import ColourTools
import SwiftUI

struct HSVSliders: View {
  // @Environment(AppHandler.self) private var store

  @Binding var hsvColour: HSVColour
  var body: some View {

    QuickSlider(
      "H",
      value: $hsvColour.hue,
      range: .unitRange,
      trackStyle: HSVTrackStyle(colour: hsvColour, component: .hue),
    )

    //    .sliderStyle(.custom(.hsv(hsvColour.wrappedValue, .hue)))

    QuickSlider(
      "S",
      value: $hsvColour.saturation,
      range: .unitRange,
      trackStyle: HSVTrackStyle(colour: hsvColour, component: .saturation),
    )
    //    .sliderStyle(.custom(.hsv(hsvColour.wrappedValue, .saturation)))

    QuickSlider(
      "V",
      value: $hsvColour.brightness,
      range: .unitRange,
      trackStyle: HSVTrackStyle(colour: hsvColour, component: .brightness),
    )
    //    .sliderStyle(.custom(.hsv(hsvColour.wrappedValue, .brightness)))

    QuickSlider(
      "A",
      value: $hsvColour.alpha,
//      value: $alpha,
      range: .unitRange,
      trackStyle: OpacityTrackStyle(colour: hsvColour.toOpaque),
    )
    //    .sliderStyle(.custom(.opacityCheckboard(colour.toOpaque)))

  }
}
