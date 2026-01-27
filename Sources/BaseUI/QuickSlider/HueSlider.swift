//
//  HueSlider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import SwiftUI

public struct HueSlider<Value: BinaryFloatingPoint & Sendable>: View {

  @Binding var hue: Value
//  @Binding var colour: HSVColour
  
  public init(hue: Binding<Value>) {
//  public init(colour: Binding<HSVColour>) {
    self._hue = hue
  }
  public var body: some View {

    QuickSlider(
      "Hue",
      value: $hue,
      range: .unitRange
    )
    .sliderStyle(.custom(.hueRainbow))

  }
}
