//
//  ColourSliderGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI

public struct ColourSliderGroup: View {

  //  @State private var colourNative: Color = .primary
  //  @State private var colourHSV: HSVColour = .white

  @State private var isHovering: Bool = false
  
  @Binding var colour: RGBColour
  //  @Binding var colourHSV: HSVColour
  let kind: ColourModelKind

  public init(
    _ colour: Binding<RGBColour>,
    kind: ColourModelKind
  ) {
    self._colour = colour
    self.kind = kind
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
            value: hsvBinding().hue,
            range: .unitRange
          )
          .sliderStyle(.custom(.hsv(hsvBinding().wrappedValue, .hue)))

          QuickSlider(
            "S",
            value: hsvBinding().saturation,
            range: .unitRange
          )
          .sliderStyle(.custom(.hsv(hsvBinding().wrappedValue, .saturation)))

          QuickSlider(
            "V",
            value: hsvBinding().brightness,
            range: .unitRange
          )
          .sliderStyle(.custom(.hsv(hsvBinding().wrappedValue, .brightness)))
      }
    }
    .labelWeight(.semibold)
    .labelColour(.secondary)
    .environment(\.maxCharacterColumns, 4)
    .environment(\.layoutSpacing, 4)
    //    .task(id: colour) {
    //      self.colourNative = colour.toColour
    //    }
  }
}

extension ColourSliderGroup {
  private func hsvBinding() -> Binding<HSVColour> {
    Binding {
      colour.toHSV
    } set: {
      colour = $0.toRGB
    }

  }

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var colour = RGBColour.green
  Form {
    ColourSliderGroup($colour, kind: .rgb)
  }
  .formStyle(.grouped)
  .padding()
  .frame(maxWidth: 300)
}
#endif
