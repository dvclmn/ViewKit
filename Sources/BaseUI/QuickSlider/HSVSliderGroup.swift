//
//  HSVSliderGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import SwiftUI
import ColourKit
import CoreTools

public struct HSVSliderGroup: View {

  @Binding var colour: HSVColour
  
  public init(_ colour: Binding<HSVColour>) {
    self._colour = colour
  }
  public var body: some View {

    SliderGroup {
      QuickSlider(
        "H",
        value: $colour.hue,
        range: .unitRange
      )
      .sliderStyle(.custom(.hueRainbow))

      QuickSlider(
        "S",
        value: $colour.saturation,
        range: .unitRange
      )
      .sliderStyle(.custom(.saturation(hue: colour.hue)))

      QuickSlider(
        "V",
        value: $colour.brightness,
        range: .unitRange
      )
      .sliderStyle(.custom(.brightness(colour.hueSatOnly.toColour)))
    }
    .environment(\.maxCharacterColumns, 4)
    .environment(\.layoutSpacing, 4)
    

  }
}

//extension HSVSliderGroup {
//
//}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var colour = HSVColour.green
//  Form {
//    HSVSliderGroup(colour: $colour)
//  }
//  .formStyle(.grouped)
//    .padding()
//    .frame(maxWidth: 300)
//}
//#endif
