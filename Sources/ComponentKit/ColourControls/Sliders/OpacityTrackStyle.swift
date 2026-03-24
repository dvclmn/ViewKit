//
//  OpacityTrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import BasePrimitives
import BaseUI
import LayoutKit
import SwiftUI

public struct OpacityTrackStyle: SliderTrackStyle {

  let colour: any ColourModel
  //  let component: RGBComponent

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
