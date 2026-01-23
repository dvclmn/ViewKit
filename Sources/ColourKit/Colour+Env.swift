//
//  EnvironmentValues.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry public var colourHandler: ColourHandler = .init()
  
  /// Colour adjustments, see ``ColourModification``
  @Entry public var colourModification: ColourModification? = nil
  @Entry public var colourModificationStrength: ModificationStrengthPreset? = nil
  @Entry public var colourPurpose: ColourPurpose? = nil
  @Entry public var colourChroma: ColourChroma? = nil
}
