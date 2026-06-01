//
//  OpacityTrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
import CoreTools
import ViewTools
import LayoutKit
import SwiftUI
import ColourTools

public struct OpacityTrackStyle: SliderTrackStyle {

  let colour: any ColourModel & SwiftUIColourConvertible
  //  let component: RGBComponent
  
  public init(colour: any ColourModel & SwiftUIColourConvertible) {
    self.colour = colour
  }

  public func makeBody(configuration: Configuration) -> some View {
    Rectangle()
      .fill(
        LinearGradient(
          colors: [.clear, colour.toColour],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
    //      .fill(.opacityBackground)
    //      .fill(component.sliderTrackGradient(colour: colour))
  }
}
