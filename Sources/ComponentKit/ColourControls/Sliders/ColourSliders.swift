//
//  ColourSliderGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI

public struct ColourSliders: View {
  @Environment(\.activeColourModel) private var activeColourModel
  @State private var isHovering: Bool = false

  @Binding var colour: RGBColour

  public init(_ colour: Binding<RGBColour>) {
    self._colour = colour
  }

  public var body: some View {

    SliderGroup {
      switch activeColourModel.wrappedValue {
        case .rgb: RGBView()
        case .hsv: HSView()
      }
    }
    .labelWeight(.semibold)
    .labelColour(.secondary)
    .environment(\.maxCharacterColumns, 4)
    .environment(\.layoutSpacing, 4)
  }
}

extension ColourSliders {
  @ViewBuilder
  private func RGBView() -> some View {
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

    QuickSlider(
      "A",
      value: $colour.alpha,
      range: .unitRange
    )
    .sliderStyle(.custom(.opacityCheckboard(colour.toOpaque)))

  }

  @ViewBuilder
  private func HSView() -> some View {
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

    QuickSlider(
      "A",
      value: $colour.alpha,
      range: .unitRange
    )
    .sliderStyle(.custom(.opacityCheckboard(colour.toOpaque)))
  }

  private func hsvBinding() -> Binding<HSVColour> {
    Binding {
      colour.toHSV
    } set: {
      colour = $0.toRGB
    }
  }

}
#if DEBUG
#Preview {
  @Previewable @State var colour = RGBColour.green
  Form {
    ColourSliders($colour)
      .environment(\.activeColourModel, .constant(.rgb))
  }
  .formStyle(.grouped)
  .padding()
  .frame(maxWidth: 300)
}
#endif
