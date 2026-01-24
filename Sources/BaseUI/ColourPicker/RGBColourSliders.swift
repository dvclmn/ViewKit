//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

public struct RGBColourSliders: View {
  //  @Environment(AppHandler.self) private var store
  //  @AppStorage("isColourPickerExpanded") var isColourPickerExpanded: Bool = false
  //  @AppStorage("areColourSlidersExpanded") var areColourSlidersExpanded: Bool = true

  @Binding var colour: RGBColour
  //  let pickerSize: CGFloat

  public init(
    colour: Binding<RGBColour>,
    //    pickerSize: CGFloat = 120
  ) {
    self._colour = colour
    //    self.pickerSize = pickerSize
  }
  public var body: some View {

    SliderGroup {
      QuickSlider(
        "R",
        value: $colour.red,
        range: .unitRange
      )
      .sliderStyle(.custom(.rgb(colour, for: .red)))

      QuickSlider(
        "G",
        value: $colour.green,
        range: .unitRange
      )
      .sliderStyle(.custom(.rgb(colour, for: .green)))

      QuickSlider(
        "B",
        value: $colour.blue,
        range: .unitRange
      )
      .sliderStyle(.custom(.rgb(colour, for: .blue)))

    }

  }
}
