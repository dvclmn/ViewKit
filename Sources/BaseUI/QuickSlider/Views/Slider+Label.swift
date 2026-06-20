//
//  Slider+Label.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
import CoreTools
import ViewTools
import SwiftUI

extension QuickSlider {
  struct SliderLabel: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double
    var body: some View {

      @Bindable var store = store
      QuickLabel(store.label)
        .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)

    }
  }
}
