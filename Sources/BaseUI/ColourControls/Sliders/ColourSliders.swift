//
//  ColourSliderGroup.swift
//  ViewKit
//
//  Created by Dave Coleman on 27/1/2026.
//

import CoreTools
import ViewTools
// import LayoutKit
import SwiftUI
import ColourTools

public struct ColourSliders: View {
  @Environment(\.activeColourModel) private var activeColourModel

  @Binding var colour: RGBColour

  public init(_ colour: Binding<RGBColour>) {
    self._colour = colour
  }

  public var body: some View {

    SliderGroup {
      switch activeColourModel.wrappedValue {
        case .rgb: RGBView()
        case .hsv: HSVSliders(hsvColour: $colour.hsv)
      }
    }
//    .labelFontStyle(.)
//    .labelWeight(.semibold)
    .labelTitleColour(.secondary)
    .environment(\.maxCharacterColumns, 4)
    .environment(\.layoutSpacing, 4)
  }
}

extension ColourSliders {
  @ViewBuilder
  private func RGBView() -> some View {
    #if os(macOS)
    QuickSlider(
      "R",
      value: $colour.red,
      range: .unitRange,
      trackStyle: RGBTrackStyle(colour: colour, component: .red)
    )

    QuickSlider(
      "G",
      value: $colour.green,
      range: .unitRange,
      trackStyle: RGBTrackStyle(colour: colour, component: .green)
    )

    QuickSlider(
      "B",
      value: $colour.blue,
      range: .unitRange,
      trackStyle: RGBTrackStyle(colour: colour, component: .blue)
    )

    QuickSlider(
      "A",
      value: $colour.alpha,
      range: .unitRange,
      trackStyle: OpacityTrackStyle(colour: colour.toOpaque)
    )
    #else
    QuickSlider("R", value: $colour.red, range: .unitRange)
    QuickSlider("G", value: $colour.green, range: .unitRange)
    QuickSlider("B", value: $colour.blue, range: .unitRange)
    QuickSlider("A", value: $colour.alpha, range: .unitRange)
    #endif
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
