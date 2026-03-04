//
//  ColourTrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import ColourKit
import SwiftUI
import UIPrimitives

public struct RGBTrackStyle: SliderTrackStyle {

  let colour: RGBColour
  let component: RGBComponent

  public func makeBody(configuration: Configuration) -> some View {
    Rectangle()
      .fill(
        .checkerboard(
          primary: RGBColour.gray(1),
          secondary: RGBColour.gray(0.7),
          scale: 5.5
        )
      )
      .fill(component.sliderTrackGradient(colour: colour))
  }
}
