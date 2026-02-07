//
//  EnvironmentValues.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry public var colourHandler: ColourHandler = .init()
  @Entry public var rgbComponent: RGBComponent?
  
  /// Colour adjustments, see ``ColourModification``
  @Entry public var colourModification: ColourModification?
  @Entry public var colourModificationStrength: ModificationStrengthPreset?
  @Entry public var colourPurpose: ColourPurpose?
  @Entry public var colourChroma: ColourChroma?
}
