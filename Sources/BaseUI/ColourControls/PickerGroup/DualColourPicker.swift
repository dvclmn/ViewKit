//
//  AnotherPickerDualColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

/// Presents both a Square Picker, and RGB/HSV Sliders
public struct ColourPicker: View {
  @Environment(\.activeColour) private var activeColour
  @Environment(\.activeColourModel) private var activeColourModel

  @State private var components: ColourPickerComponents

  @Binding var primaryColour: RGBColour
  @Binding var secondaryColour: RGBColour?

  public init(
    primary: Binding<RGBColour>,
    secondary: Binding<RGBColour?> = .constant(nil),
    components: ColourPickerComponents
  ) {
    self._primaryColour = primary
    self._secondaryColour = secondary
    self._components = State(initialValue: components)
  }

  public var body: some View {


    VStack {
      if let secondaryBinding = Binding($secondaryColour) {
//      if secondaryColour != nil {
        
        ColourLevelView(
          level: activeColour.wrappedValue,
          foreground: primaryColour,
          background: secondaryBinding.wrappedValue,
          diameter: 30,
          overlapFactor: 0.5
        )
        
        ColourLevelSwitch(
          level: activeColour,
          foreground: $primaryColour,
          background: secondaryBinding,
          diameter: 30,
          overlapFactor: 0.5,
          mode: .switcher
        )
//        QuickerPicker(activeColour.wrappedValue.name, selection: activeColour)
      }
      ToggleButtonGroup(components: $components)
        .frame(maxWidth: .infinity, alignment: .trailing)

      if components.contains(.square) {
        SquareColourPicker($primaryColour)
      }

      if components.contains(.sliders) {
        ColourSliders($primaryColour)
      }

      if components.isEmpty {
        StateView("No components specified")
          .controlSize(.small)
      }
    }
  }
}
