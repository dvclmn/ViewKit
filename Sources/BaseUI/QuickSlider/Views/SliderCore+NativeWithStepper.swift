//
//  SliderCore+NativeWithStepper.swift
//  ViewKit
//
//  Created by Dave Coleman on 30/7/2026.
//

import CoreTools
import SwiftUI
import ViewTools

extension QuickSlider {
  struct NativeSlider_WithStepper: View {
    @Environment(\.stepStyle) private var stepStyle
    //    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double
    let step: Double
    let configuration: SliderConfiguration
    @Bindable var handler: SliderHandler
    //    let label: SliderLabel

    var body: some View {

      StepperView(step)

      if #available(macOS 26.0, iOS 26.0, *) {
        Slider(
          value: $value,
          in: configuration.range,
          step: step,
          neutralValue: configuration.neutralValue,
        ) {
          if let text = configuration.label?.text {
            Text(text)
          }
//          EmptyView()
          //          QuickSlider.SliderLabelView(
          //            value: $value,
          //            configuration: configuration,
          //            label: label,
          //          )
        } onEditingChanged: { editing in
          //          handleOnEdit(editing)
          handler.handleOnEdit(editing, configuration: configuration)
        }
                .labelsHidden()

      } else {
        Slider(
          value: $value,
          in: configuration.range,
          step: step,
        ) {
          if let text = configuration.label?.text {
            Text(text)
          }
          //          QuickSlider.SliderLabel(value: $value, configuration: configuration)

          //          QuickSlider.SliderLabelView(
          //            value: $value,
          //            configuration: configuration,
          //            label: label,
          //          )

          

        } onEditingChanged: { editing in
          //          handleOnEdit(editing)
          handler.handleOnEdit(editing, configuration: configuration)
        }
                .labelsHidden()
      }
    }
  }
}
extension QuickSlider.NativeSlider_WithStepper {

  @ViewBuilder
  private func StepperView(_ step: Double) -> some View {
    if stepStyle == .stepper {
      Stepper(
//        handler.labelText(with: configuration),
                configuration.label?.text ?? "",
        value: $value,
        step: step,
      )
      .labelsHidden()
    }
  }

}
