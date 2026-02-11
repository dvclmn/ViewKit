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
  @OptionallyPersisted var isEnabled: Bool
  
  
  private init(
    colour: Binding<RGBColour>,
    kind: Binding<ColourModelKind>,
    components: ColourPickerComponents,
    configuration: ToggleConfiguration,
  ) {
    self._colour = colour
    self._kind = kind
    self.components = components
    self.title = configuration.title
    self._isEnabled = configuration.persistedValue
  }
  
  /// Public initializers delegate to private init
  /// Key-based initialiser (title derived from key)
  public init<K: ToggleKey>(
    _ key: K.Type,
    colour: Binding<RGBColour>,
    kind: Binding<ColourModelKind>,
    components: ColourPickerComponents,
  ) {
    self.init(
      colour: colour,
      kind: kind,
      components: components,
      configuration: ToggleConfiguration(key)
    )
  }
  
  /// Transient (non-persisted) initialiser
  public init(
    _ title: String = "Enabled",
    transient defaultEnabled: Bool = true,
    colour: Binding<RGBColour>,
    kind: Binding<ColourModelKind>,
    components: ColourPickerComponents,
  ) {
    self.init(
      colour: colour,
      kind: kind,
      components: components,
      configuration: ToggleConfiguration(title, transient: defaultEnabled)
    )
  }

  public var body: some View {

    DisclosureSection(<#T##key: ToggleKey.Type##ToggleKey.Type#>, content: <#T##() -> View#>)
//    DisclosureSection("Colour Picker", persistenceKey: "isColourPickerExpanded") {
////    DisclosureGroup("Picker", isExpanded: $isColourPickerExpanded) {
      SquareColourPicker($colour, size: pickerSize)
//    }
    
    DisclosureSection("Sliders", persistenceKey: "areColourSlidersExpanded") {
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
