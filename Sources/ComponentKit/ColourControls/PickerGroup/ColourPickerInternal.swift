//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI

/// Presents a Square Picker and/or RGB/HSV Sliders, depending on
/// the `components` privided.
///
/// Note: Not a Dual picker, this is for handling one colour only
/// See ``DualColourPicker`` for handling fore/background
//struct ColourPicker: View {
//  @Environment(\.activeColourModel) private var activeColourModel
//
//  @Binding var colour: RGBColour
//  @State private var components: ColourPickerComponents
//
//  init(
//    colour: Binding<RGBColour>,
//    components: ColourPickerComponents,
//  ) {
//    self._colour = colour
//    self._components = State(initialValue: components)
//  }
//
//  var body: some View {
//
//    VStack {
//      ToggleButtonGroup(components: $components)
//      .frame(maxWidth: .infinity, alignment: .trailing)
//
//      if components.contains(.square) {
//        SquareColourPicker($colour)
//      }
//
//      if components.contains(.sliders) {
//        ColourSliders($colour)
//      }
//
//      if components.isEmpty {
//        StateView("No components specified")
//          .controlSize(.small)
//      }
//    }
//  }
//}
