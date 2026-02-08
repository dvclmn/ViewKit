//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

public struct AnotherColourPicker: View {
  //  @Environment(AppHandler.self) private var store
  @AppStorage("isColourPickerExpanded") var isColourPickerExpanded: Bool = false
  @AppStorage("areColourSlidersExpanded") var areColourSlidersExpanded: Bool = true

  @Binding var colour: RGBColour
  let kind: ColourModelKind
  //  @Binding var colour: HSVColour
  let pickerSize: CGFloat

  public init(
    colour: Binding<RGBColour>,
    kind: ColourModelKind,
    pickerSize: CGFloat = 120
  ) {
    self._colour = colour
    self.kind = kind
    self.pickerSize = pickerSize
  }
  public var body: some View {

    DisclosureGroup("Picker", isExpanded: $isColourPickerExpanded) {
      SquareColourPicker($colour, size: pickerSize)
    }

    DisclosureGroup(
      "Sliders",
      isExpanded: $areColourSlidersExpanded
    ) {
      ColourSliderGroup($colour, kind: kind)
    }
    .disclosureGroupStyle(.sectioned)
  }
}
