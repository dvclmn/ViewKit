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
    let handler: SliderHandler
    #if os(macOS)
    let appKitTrack: ((SliderTrackConfiguration) -> AppKitSliderTrack)?
    #endif

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
          accessibilityLabel: configuration.label.text,
          onEditingChanged: handleOnEdit(_:),
        )
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
      StepperView(step)

      if #available(macOS 26.0, iOS 26.0, *) {
        Slider(
          value: $value,
          in: configuration.range,
          step: step,
          neutralValue: configuration.neutralValue,
        ) {
          QuickSlider.SliderLabel(value: $value, configuration: configuration)
        } onEditingChanged: { editing in
          handleOnEdit(editing)
        }
        .labelsHidden()
      } else {
        Slider(
          value: $value,
          in: configuration.range,
          step: step,
        ) {
          QuickSlider.SliderLabel(value: $value, configuration: configuration)
        } onEditingChanged: { editing in
          handleOnEdit(editing)
        }
        .labelsHidden()
      }
    } else {
      if #available(macOS 26.0, iOS 26.0, *) {
        Slider(
          value: $value,
          in: configuration.range,
          neutralValue: configuration.neutralValue,
        ) {
          QuickSlider.SliderLabel(value: $value, configuration: configuration)
        } onEditingChanged: { editing in
          handleOnEdit(editing)
        }
        .labelsHidden()
      } else {
        Slider(
          value: $value,
          in: configuration.range,
        ) {
          QuickSlider.SliderLabel(value: $value, configuration: configuration)
        } onEditingChanged: { editing in
          handleOnEdit(editing)
        }
        .labelsHidden()
      }
    }
  }

  @ViewBuilder
  private func StepperView(_ step: Double) -> some View {
    if stepStyle == .stepper {
      Stepper(
        configuration.label.text,
        value: $value,
        step: step,
      )
      .labelsHidden()
    }
  }

  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    handler.updatePhase(phase, didChangeSlider: configuration.didChangeSlider)
  }
}
