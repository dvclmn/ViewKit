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

    //    ControlGroup {
    HStack {
      Toggle(isOn: $components.bindingToggle(option: .square)) {
        Label("Toggle Square", systemImage: "square")
      }

      Toggle(isOn: $components.bindingToggle(option: .sliders)) {
        Label("Toggle Sliders", systemImage: Icons.options.icon)
      }
      //      .labelsHidden()
      //    .buttonStyle(.accessoryBarAction)
    }
    .toggleStyle(.button)
    .labelStyle(.iconOnly)
  }
}
