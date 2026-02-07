//
//  HSVSliderGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI

public struct HSVSliderGroup: View {

  @State private var colourNative: Color = .primary
  @State private var colourRGB: RGBColour = .white
  
  @Binding var colour: HSVColour
//  @Binding var colourHSV: HSVColour
  let kind: ColourModelKind

  public init(
    _ colour: Binding<HSVColour>,
    kind: ColourModelKind =
  ) {
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
    .labelWeight(.semibold)
    .labelColour(.secondary)
    .environment(\.maxCharacterColumns, 4)
    .environment(\.layoutSpacing, 4)
    .task(id: colour) {
      self.colourNative = colour.toColour
    }

  }
}

extension HSVSliderGroup {

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var colour = HSVColour.green
  Form {
    HSVSliderGroup($colour)
  }
  .formStyle(.grouped)
  .padding()
  .frame(maxWidth: 300)
}
#endif
