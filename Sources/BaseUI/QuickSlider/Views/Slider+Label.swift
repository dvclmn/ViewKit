//
//  Slider+Label.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import BasePrimitives
import SwiftUI

extension QuickSlider {
  struct SliderLabel: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double
    var body: some View {

      @Bindable var store = store
      MaybeLabel(store.label)
        .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)

    }
  }
}
