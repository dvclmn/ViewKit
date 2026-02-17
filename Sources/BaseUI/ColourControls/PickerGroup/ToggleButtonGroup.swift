//
//  ToggleButtonGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

import CoreTools
import SwiftUI

struct ToggleButtonGroup: View {

  @Binding var components: ColourPickerComponents
  var body: some View {

    ControlGroup {
      //    HStack {
      Toggle(isOn: $components.bindingToggle(option: .square, preventEmpty: true)) {
        Label("Toggle Square", systemImage: "square")
      }
      .foregroundStyle(components.contains(.square) ? .primary : .secondary)

      Toggle(isOn: $components.bindingToggle(option: .sliders, preventEmpty: true)) {
        Label("Toggle Sliders", systemImage: Icons.options.icon)
      }
      .foregroundStyle(components.contains(.sliders) ? .primary : .secondary)
      //      .labelsHidden()
      //    .buttonStyle(.accessoryBarAction)
    }
    .toggleStyle(.button)
    .labelStyle(.iconOnly)
//    .fontWeight(.bold)

    .tint(.darkGrey)
  }
}
