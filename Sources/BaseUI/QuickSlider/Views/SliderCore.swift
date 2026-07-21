//
//  Component+Slider.swift
//  ViewKit
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI

extension QuickSlider {
  struct SliderCore: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue
    @Environment(\.colorScheme) private var colourScheme
    @Environment(\.stepStyle) private var stepStyle
    @Environment(\.sliderComponents) private var sliderComponents
    @Environment(\.isEnabled) private var isEnabled

    @Binding var value: Double
    let track: TrackBackground
    #if os(macOS)
    let appKitTrack: AppKitTrackBackground?
    #endif
    var body: some View {

      /// If there's a track, then it's a Custom Slider
      let configuration = store.trackConfiguration(value: value, colourScheme: colourScheme)
      if let track = track(configuration) {
        // MARK: - Custom Slider
        #if os(macOS)
        if let appKitTrack = appKitTrack?(configuration) {
          AppKitSlider(
            value: $value,
            range: store.range,
            step: store.step,
            track: appKitTrack,
            drawsTrack: sliderComponents.contains(.track),
            drawsThumb: sliderComponents.contains(.thumb),
            isEnabled: isEnabled,
            accessibilityLabel: store.label.text,
            onEditingChanged: handleOnEdit(_:),
          )
          .padding(-AppKitSlider.pressedKnobVisualOverflow)
          .frame(height: store.trackHeightWithBuffer)
          //          .debugFrame("AppKit-based slider track", .purple)

        } else {
          SliderCustom(value: $value, track: track)
        }
        #else
        SliderCustom(value: $value, track: track)
        #endif

      } else {

        // MARK: - Native Slider
        NativeSliderView()
        /// Using `labelsHidden` as Label is handled in ``SliderComponents``
        @Bindable var store = store

        
      }
    }
  }
}

extension QuickSlider.SliderCore {
  
  @ViewBuilder
  private func NativeSliderView() -> some View {
    if let step = store.step {
      StepperView(step)
      
      Slider(
        value: $value,
        in: store.range,
        step: step,
      ) {
        QuickSlider.SliderLabel(value: $value)
        
      } onEditingChanged: { editing in
        handleOnEdit(editing)
      }
      .labelsHidden()
      
    } else {
      
      Slider(
        value: $value,
        in: store.range,
      ) {
        QuickSlider.SliderLabel(value: $value)
        
      } onEditingChanged: { editing in
        handleOnEdit(editing)
      }
      .labelsHidden()
    }
  }

  @ViewBuilder
  private func StepperView(_ step: Double) -> some View {
    if stepStyle == .stepper {
      //    if let step = store.step, stepStyle == .stepper {
      Stepper(
        store.label.text,
        value: $value,
        step: step,
      )
      .labelsHidden()
    }
  }

  private var columns: Int { store.sliderTrackColumns }

  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }

  // Min Max not in use atm
  @ViewBuilder
  private func MinMaxLabel(_ label: MinMaxLabel) -> some View {
    if let value = label.value(from: store) {
      Image(systemName: value)
    } else {
      Image(systemName: "eye")
        .hidden()
    }
  }
}

enum MinMaxLabel {
  case min
  case max

  func value(from store: SliderHandler) -> String? {
    fatalError("Not currently implemented")
    //    switch self {
    //      case .min: store.minMaxLabels?.0
    //      case .max: store.minMaxLabels?.1
    //    }
  }
}
