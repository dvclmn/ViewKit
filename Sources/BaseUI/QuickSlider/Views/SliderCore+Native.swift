//
//  SliderCore+Native.swift
//  ViewKit
//
//  Created by Dave Coleman on 30/7/2026.
//

import CoreTools
import SwiftUI
import ViewTools

extension QuickSlider {
  struct NativeSlider: View {

    @Binding var value: Double
    let configuration: SliderConfiguration
    @Bindable var handler: SliderHandler
//    let label: SliderLabel

    var body: some View {
      if #available(macOS 26.0, iOS 26.0, *) {
        Slider(
          value: $value,
          in: configuration.range,
          neutralValue: configuration.neutralValue,
        ) {
          if let text = configuration.label?.text {
            Text(text)
          }
//          QuickSlider.SliderLabelView(value: $value, configuration: configuration, label: label)
        } onEditingChanged: { editing in
          handler.handleOnEdit(editing, configuration: configuration)
        }
                .labelsHidden()

      } else {
        Slider(
          value: $value,
          in: configuration.range,
        ) {
          if let text = configuration.label?.text {
            Text(text)
          }
//          QuickSlider.SliderLabelView(value: $value, configuration: configuration, label: label)
          //          QuickSlider.SliderLabel(value: $value, configuration: configuration)
        } onEditingChanged: { editing in
          handler.handleOnEdit(editing, configuration: configuration)
        }
                .labelsHidden()

      }
    }
  }
}
