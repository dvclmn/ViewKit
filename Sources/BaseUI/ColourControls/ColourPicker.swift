//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI

/// Presents both a Square Picker, and RGB/HSV Sliders.
/// Note: Not a Dual picker, this is for handling one colour only
/// See ``DualColourPicker`` for handling fore/background
public struct ColourPicker: View {
  //  @AppStorage("isColourPickerExpanded") var isColourPickerExpanded: Bool = false
  //  @AppStorage("areColourSlidersExpanded") var areColourSlidersExpanded: Bool = true

  let title: String
  @Binding var colour: RGBColour
  @Binding var kind: ColourModelKind
  let components: ColourPickerComponents
  //  @OptionallyPersisted var isEnabled: Bool

  public init(
    title: String,
    colour: Binding<RGBColour>,
    kind: Binding<ColourModelKind>,
    components: ColourPickerComponents,
    //    configuration: ToggleConfiguration,
  ) {
    self.title = title
    self._colour = colour
    self._kind = kind
    self.components = components
    //    self.title = configuration.title
    //    self._isEnabled = configuration.persistedValue
  }

  public var body: some View {

    if components.contains(.square) {
      SquareColourPicker($colour)
    }

    if components.contains(.sliders) {
      ColourSliders($colour, kind: kind)
    }

    if components.isEmpty {
      StateView("No components specified")
        .controlSize(.small)
    }

  }
}
