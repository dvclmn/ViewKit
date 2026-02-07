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
  @State private var colourHSV: HSVColour = .white
  
  @Binding var colour: RGBColour
//  @Binding var colourHSV: HSVColour
  let kind: ColourModelKind

  public init(
    _ colour: Binding<RGBColour>,
    kind: ColourModelKind = .hsv
  ) {
    self._colour = colour
  }
  public var body: some View {

    SliderGroup {
      switch kind {
        case .rgb:
          QuickSlider(
            "R",
            value: $colour.red,
            range: .unitRange
          )
          .sliderStyle(.custom(.rgb(colour, .red)))
//          .sliderStyle(.custom(.rgb(colour, for: .red)))
          
          QuickSlider(
            "G",
            value: $colour.green,
            range: .unitRange
          )
          .sliderStyle(.custom(.rgb(colour, .green)))
          
          QuickSlider(
            "B",
            value: $colour.blue,
            range: .unitRange
          )
          .sliderStyle(.custom(.rgb(colour, .blue)))
          
          
        case .hsv:
        QuickSlider(
          "H",
          value: $colour.hue,
          range: .unitRange
        )
        .sliderStyle(.custom(.hsv(colourHSV, .hue)))
//        .sliderStyle(.custom(.hueRainbow))

        QuickSlider(
          "S",
          value: $colour.saturation,
          range: .unitRange
        )
        .sliderStyle(.custom(.hsv(colourHSV, .saturation)))

        QuickSlider(
          "V",
          value: $colour.brightness,
          range: .unitRange
        )
        .sliderStyle(.custom(.hsv(colourHSV, .brightness)))
      }
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
