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

    #warning("Turning this off, need to reference control sizes for Sliders, to replace thumb size parameter")
//    SquareColourPicker(
//      <#T##colour: Binding<RGBColour>##Binding<RGBColour>#>,
//      size: <#T##CGFloat#>,
//      thumbSize: <#T##CGFloat#>
//    )
//    DisclosureSection(<#T##key: ToggleKey.Type##ToggleKey.Type#>, content: <#T##() -> View#>)
//    DisclosureSection("Colour Picker", persistenceKey: "isColourPickerExpanded") {
////    DisclosureGroup("Picker", isExpanded: $isColourPickerExpanded) {
//      SquareColourPicker($colour, size: pickerSize)
//    }
    
//    DisclosureSection("Sliders", persistenceKey: "areColourSlidersExpanded") {
      ColourSliderGroup($colour, kind: kind)
//    }

//    DisclosureGroup(
//      "Sliders",
//      isExpanded: $areColourSlidersExpanded
//    ) {
//    }
//    .disclosureGroupStyle(.sectioned)
  }
}
