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
      Button {
        if components.contains(.square) {
          guard components.contains(.sliders) else { return }
          components.remove(.square)
        } else {
          components.insert(.square)
        }
      } label: {
        Label("Toggle Square", systemImage: "square")
          .labelStyle(.iconOnly)
      }
      //      .tint(components.contains(.square) ? Color.accentColor : nil)
      Button {
        if components.contains(.sliders) {
          guard components.contains(.square) else { return }
          components.remove(.sliders)
        } else {
          components.insert(.sliders)
        }
      } label: {
        Label("Toggle Sliders", systemImage: Icons.options.icon)
          .labelStyle(.iconOnly)
      }
      .tint(.pink)
//      .tint(components.contains(.sliders) ? Color.accentColor : nil)
//    }
    .labelsHidden()
    //    .buttonStyle(.accessoryBarAction)
  }
}
