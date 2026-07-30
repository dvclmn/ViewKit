//
//  Slider+Label.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/3/2026.
//

import CoreTools
import SwiftUI
import ViewTools

extension QuickSlider {
  struct SliderLabelView: View {
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double
    let configuration: SliderConfiguration
    let label: SliderLabel

    var body: some View {

      Group {
        if let configLabel = configuration.label {
          QuickLabel(configLabel)
          //          SliderLabel(value: $value, configuration: configuration)
        } else {
          label
        }
      }
      .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)

      //      QuickLabel(configuration.label)
      //        .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)
    }
  }
}
