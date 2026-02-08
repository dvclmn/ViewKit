//
//  AnotherPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

public struct AnotherColourPicker: View {
  @AppStorage("isColourPickerExpanded") var isColourPickerExpanded: Bool = false
  @AppStorage("areColourSlidersExpanded") var areColourSlidersExpanded: Bool = true

  @Binding var colour: RGBColour
  let kind: ColourModelKind
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

    DisclosureSection("Colour Picker", isExpanded: $isColourPickerExpanded) {
//    DisclosureGroup("Picker", isExpanded: $isColourPickerExpanded) {
      SquareColourPicker($colour, size: pickerSize)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    DisclosureSection("Sliders", isExpanded: $areColourSlidersExpanded) {
      ColourSliderGroup($colour, kind: kind)
      
    }

//    DisclosureGroup(
//      "Sliders",
//      isExpanded: $areColourSlidersExpanded
//    ) {
//    }
//    .disclosureGroupStyle(.sectioned)
  }
}
