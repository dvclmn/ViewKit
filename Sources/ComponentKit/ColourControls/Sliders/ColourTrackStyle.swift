//
//  ColourTrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI
import LayoutKit
import BasePrimitives

public struct RGBTrackStyle: SliderTrackStyle {

  let colour: RGBColour
  let component: RGBComponent

  public func makeBody(configuration: Configuration) -> some View {
    Rectangle()
      .fill(.opacityBackground)
      .fill(component.sliderTrackGradient(colour: colour))
  }
}

public struct HSVTrackStyle: SliderTrackStyle {

  let colour: HSVColour
  let component: HSVComponent

  public func makeBody(configuration: Configuration) -> some View {
    Rectangle()
      .fill(.opacityBackground)
      .fill(gradient)
  }
}

extension HSVTrackStyle {
  private var gradient: LinearGradient {
    let gradient =
      switch component {
        case .hue: LinearGradient.rainbow()
        case .saturation:
          LinearGradient(
            colors: [.gray, Color(hue: colour.hue, saturation: 1.0, brightness: 1.0)],
            startPoint: .leading,
            endPoint: .trailing
          )
        case .brightness:
          LinearGradient(
            colors: [.black, colour.hueSatOnly.toColour],
            startPoint: .leading,
            endPoint: .trailing
          )
        case .alpha:
          preconditionFailure("Don't pass alpha to create a slider track gradient")
      }
    return gradient
    //    return AnyShapeStyle(gradient)
  }
}
