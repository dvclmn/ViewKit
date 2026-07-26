//
//  SliderComponents.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import CoreTools
import SwiftUI
import ViewKitCore
import ViewTools

extension QuickSlider {
  struct SliderComponents: View {
    @Environment(\.sliderComponents) private var sliderComponents
    @Environment(\.sliderTrackMaxWidth) private var sliderTrackMaxWidth
    @Environment(\.formatValue) private var formatValue
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double
    let configuration: SliderConfiguration
    let handler: SliderHandler
    #if os(macOS)
    let appKitTrack: ((SliderTrackConfiguration) -> AppKitSliderTrack)?
    #endif

    var body: some View {
      if sliderComponents.contains(.label) {
        SliderLabel(value: $value, configuration: configuration)
      }

      #if os(macOS)
      SliderCore(
        value: $value,
        configuration: configuration,
        handler: handler,
        appKitTrack: appKitTrack,
      )
      .frame(width: sliderTrackMaxWidth)
      .frame(maxWidth: .infinity, alignment: .trailing)
      #else
      SliderCore(value: $value, configuration: configuration, handler: handler)
        .frame(width: sliderTrackMaxWidth)
        .frame(maxWidth: .infinity, alignment: .trailing)
      #endif

      if sliderComponents.contains(.units) {
        Group {
          if let characterSize = configuration.characterSize {
            TextColumns(
              characterSize: characterSize,
              alignment: .trailing,
            ) {
              SliderValueText()
            }
          } else {
            SliderValueText()
          }
        }
        .textSelection(.disabled)
        .onDoubleTap($value, defaultValue: sliderDefaultValue)
        .contextMenu { ContextMenuItems() }
      }
    }
  }
}

extension QuickSlider.SliderComponents {
  @ViewBuilder
  private func SliderValueText() -> some View {
    Text(formatValue.format(value.toDouble, configuration.range))
  }
  @ViewBuilder
  private func ContextMenuItems() -> some View {
    Button {
      copyStringToClipboard("\(value)")
    } label: {
      Label("Copy Value", systemImage: Icons.copy.icon)
    }

    if let sliderDefaultValue {
      Divider()
      Button {
        value = sliderDefaultValue
      } label: {
        Label("Reset to Default", systemImage: Icons.refresh.icon)
      }
    }
  }
}
