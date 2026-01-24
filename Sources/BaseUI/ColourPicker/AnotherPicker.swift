//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import SwiftUI
import ColourKit

struct AnotherColourPicker: View {
//  @Environment(AppHandler.self) private var store
  @Binding var colour: HSVColour
  var body: some View {
    
    DisclosureGroup("Picker", isExpanded: $isColourPickerExpanded) {
      SquareColourPicker(
        activeColour.isInner
        ? $config.innerShape.colour
        : $config.outerShape.colour,
        size: 120
      )
    }
    
    DisclosureGroup(
      "Sliders",
      isExpanded: $areColourSlidersExpanded
    ) {
      SliderGroup {
        QuickSlider(
          "Hue",
          value:
            activeColour.isInner
          ? $config.innerShape.colour.hue
          : $config.outerShape.colour.hue,
          range: .unitRange
        )
        .sliderStyle(.custom(.hueRainbow))
        
        QuickSlider(
          "Saturation",
          value:
            activeColour.isInner
          ? $config.innerShape.colour.saturation
          : $config.outerShape.colour.saturation,
          range: .unitRange
        )
        .sliderStyle(
          .custom(
            .saturation(
              activeColour.isInner
              ? config.innerShape.colour.saturation
              : config.outerShape.colour.saturation
            )
          )
        )
        
        QuickSlider(
          "Brightness",
          value:
            activeColour.isInner
          ? $config.innerShape.colour.brightness
          : $config.outerShape.colour.brightness,
          range: .unitRange
        )
        .sliderStyle(
          .custom(
            .brightness(
              activeColour.isInner
              ? config.innerShape.colour.hueSatOnly.toColour
              : config.outerShape.colour.hueSatOnly.toColour
            )
          )
        )
      }
    }
  }
}

//extension ExampleView {
//  
//}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var store = AppHandler()
//  ExampleView()
//    .environment(store)
//}
//#endif
