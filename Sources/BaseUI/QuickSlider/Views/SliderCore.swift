//
//  SliderCore.swift
//  ViewKit
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI

extension QuickSlider {
  struct SliderCore: View {
    @Environment(\.colorScheme) private var colourScheme
    @Environment(\.stepStyle) private var stepStyle
    @Environment(\.sliderComponents) private var sliderComponents
    @Environment(\.isEnabled) private var isEnabled

    @Binding var value: Double
    let configuration: SliderConfiguration
    @Bindable var handler: SliderHandler
    #if os(macOS)
    let appKitTrack: ((SliderTrackConfiguration) -> AppKitSliderTrack)?
    #endif

    let label: SliderLabel

    var body: some View {
      #if os(macOS)
      if let appKitTrack {
        AppKitSlider(
          value: $value,
          range: configuration.range,
          step: configuration.step,
          track: appKitTrack(
            configuration.trackConfiguration(value: value, colourScheme: colourScheme)
          ),
          drawsTrack: sliderComponents.contains(.track),
          drawsThumb: sliderComponents.contains(.thumb),
          isEnabled: isEnabled,
          accessibilityLabel: configuration.label?.text,
        ) { editing in
          handler.handleOnEdit(editing, configuration: configuration)
        }
        //          onEditingChanged: handleOnEdit(_:),

        .padding(-AppKitSlider.pressedKnobVisualOverflow)
        .frame(height: AppKitSlider.controlHeight)
      } else {
        NativeSliderView()
      }
      #else
      NativeSliderView()
      #endif
    }
  }
}

extension QuickSlider.SliderCore {
  @ViewBuilder
  private func NativeSliderView() -> some View {
    if let step = configuration.step {
      QuickSlider.NativeSlider_WithStepper(
        value: $value,
        step: step,
        configuration: configuration,
        handler: handler,
//        label: label,
      )
    } else {
      QuickSlider.NativeSlider(
        value: $value,
        configuration: configuration,
        handler: handler,
//        label: label,
      )
    }
  }
}
