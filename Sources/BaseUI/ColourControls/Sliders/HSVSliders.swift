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
    #if os(macOS)
    QuickSlider(
      "H",
      value: $hsvColour.hue,
      range: .unitRange,
      trackStyle: HSVTrackStyle(colour: hsvColour, component: .hue),
    )

    QuickSlider(
      "S",
      value: $hsvColour.saturation,
      range: .unitRange,
      trackStyle: HSVTrackStyle(colour: hsvColour, component: .saturation),
    )

    QuickSlider(
      "V",
      value: $hsvColour.brightness,
      range: .unitRange,
      trackStyle: HSVTrackStyle(colour: hsvColour, component: .brightness),
    )

    QuickSlider(
      "A",
      value: $hsvColour.alpha,
      range: .unitRange,
      trackStyle: OpacityTrackStyle(colour: hsvColour.toOpaque),
    )
    #else
    QuickSlider("H", value: $hsvColour.hue, range: .unitRange)
    QuickSlider("S", value: $hsvColour.saturation, range: .unitRange)
    QuickSlider("V", value: $hsvColour.brightness, range: .unitRange)
    QuickSlider("A", value: $hsvColour.alpha, range: .unitRange)
    #endif
  }
}
