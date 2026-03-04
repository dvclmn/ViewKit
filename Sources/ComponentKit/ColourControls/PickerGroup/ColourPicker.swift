//
//  AnotherPickerDualColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import CoreTools
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

  public init(
    primary: Binding<RGBColour>,
    secondary: Binding<RGBColour>,
    components: ColourPickerComponents
  ) {
    self._primaryColour = primary
    self._secondaryColour = Binding(secondary)
    self._components = State(initialValue: components)
  }

  public var body: some View {

    VStack(spacing: Styles.sizeRegular.bump) {
      HStack {
        ColourLevelSwitch(
          primary: $primaryColour,
          secondary: $secondaryColour,
          diameter: 26,
          overlapFactor: 0.24,
        )
        Spacer()

        ColourModelSwitch()
        ToggleButtonGroup(components: $components)

      }

      if components.contains(.square) {
        SquareColourPicker($primaryColour)
      }

      if components.contains(.sliders) {
        ColourSliders($primaryColour)
      }

      if components.isEmpty {
        Text("No components specified")
          .controlSize(.small)
      }
    }  // END main vstack
  }
}

extension ColourPicker {
  @ViewBuilder
  private func ColourModelSwitch() -> some View {
    ControlGroup {
      Button {
        activeColourModel.wrappedValue.next()
      } label: {
        Label(
          activeColourModel.wrappedValue.name, systemImage: activeColourModel.wrappedValue.icon.toString
        )
        .labelStyle(.iconOnly)
      }
      //      .scaleEffect(x: 1.0, y: -1.0, anchor: .center)
    }
  }
}
