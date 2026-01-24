//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

public struct AnotherColourPicker: View {
  //  @Environment(AppHandler.self) private var store
  @AppStorage("isColourPickerExpanded") var isColourPickerExpanded: Bool = false
  @AppStorage("areColourSlidersExpanded") var areColourSlidersExpanded: Bool = true

  @Binding var colour: HSVColour
  let pickerSize: CGFloat

  public init(
    colour: Binding<HSVColour>,
    pickerSize: CGFloat = 120
  ) {
    self._colour = colour
    self.pickerSize = pickerSize
  }
  public var body: some View {

    DisclosureGroup("Picker", isExpanded: $isColourPickerExpanded) {
      SquareColourPicker($colour, size: pickerSize)
    }

    DisclosureGroup(
      "Sliders",
      isExpanded: $areColourSlidersExpanded
    ) {
      SliderGroup {
        QuickSlider(
          "Hue",
          value: $colour.hue,
          range: .unitRange
        )
        .sliderStyle(.custom(.hueRainbow))

        QuickSlider(
          "Saturation",
          value: $colour.saturation,
          range: .unitRange
        )
        .sliderStyle(.custom(.saturation(colour.saturation)))

        QuickSlider(
          "Brightness",
          value: $colour.brightness,
          range: .unitRange
        )
        .sliderStyle(.custom(.brightness(colour.hueSatOnly.toColour)))
      }
    }
    .disclosureGroupStyle(.custom)
  }
}
