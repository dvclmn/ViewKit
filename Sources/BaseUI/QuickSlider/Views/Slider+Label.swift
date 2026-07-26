//
//  Slider+Label.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/3/2026.
//

import CoreTools
import ViewTools
import SwiftUI

extension QuickSlider {
  struct SliderLabel: View {
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double
    let configuration: SliderConfiguration
    var body: some View {
      QuickLabel(configuration.label)
        .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)
    }
  }
}
