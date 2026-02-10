//
//  HueSlider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import ColourKit
import SwiftUI
import CoreTools

public struct HueSlider<Value: SliderFloat>: View {

  let title: String?
  @Binding var hue: Double
//  @Binding var colour: HSVColour
  
  public init(
    _ title: String? = nil,
    hue: Binding<Double>
  ) {
//  public init(colour: Binding<HSVColour>) {
    self.title = title
    self._hue = hue
  }
  public var body: some View {

    QuickSlider(
      title ?? "Hue",
      value: $hue,
      range: .unitRange
    )
    .sliderStyle(.custom(.gradient(LinearGradient.rainbow())))
    
//    QuickSlider(
//      title ?? "Hue",
//      value: $hue,
//      range: .unitRange
//    )
//    .sliderStyle(.custom(.hsv))

  }
}
