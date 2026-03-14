//
//  EnvironmentValues.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

extension EnvironmentValues {
//  @Entry public var colourHandler: ColourHandler = .init()
  @Entry public var rgbComponent: RGBComponent?
  @Entry public var hsvComponent: HSVComponent?
  
  /// Colour adjustments, see ``ColourModification``
  @Entry public var colourModification: ColourModification?
  @Entry public var colourModificationStrength: ModificationStrengthPreset?
  @Entry public var colourPurpose: ColourPurpose?
  @Entry public var colourChroma: ColourChroma?
  
  @Entry public var activeColourHierarchy: Binding<HierarchicalColour> = .constant(.primary)
//  @Entry public var activeColour: Binding<ColourLevel> = .constant(.foreground)
  @Entry public var activeColourModel: Binding<ColourModelKind> = .constant(.rgb)
  @Entry public var hsvPrimaryRepresentation: Binding<HSVColour>? = nil
}
