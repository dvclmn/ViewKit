//
//  Contrastable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

public protocol HSVConvertible {

  associatedtype Model: ColourModel
  
  var toHSV: HSVColour { get }
  func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose,
    chroma: ColourChroma,
  ) -> Model
  
}

public protocol ColourAdjustable {
  func applying(adjustment: HSVAdjustment) -> Self
  
}
