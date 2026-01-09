//
//  Contrastable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

//
nonisolated public protocol HSVAdjustable: ColourModel, LuminanceReadable {

  var toHSV: HSVColour { get }
  init(fromHSV hsv: HSVColour)
  
  func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose,
    chroma: ColourChroma,
  ) -> Self
  
  func contrastColour(modification: ColourModification?) -> Self
}

//
extension HSVAdjustable {
  
  public func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose = .legibility,
    chroma: ColourChroma = .standard,
  ) -> Self {
    
    let hsv = self.toHSV
    
    guard strength.adjustmentStrength > 0 else { return self }
//    
    let adjustment = HSVAdjustment.applyingModifiers(
      for: self,
      strength: strength,
      purpose: purpose,
      chroma: chroma
    )
    
    let adjustedHSV = hsv.applying(adjustment: adjustment)
    
    let adjustedColour = Self(fromHSV: adjustedHSV)
    
    return adjustedColour
//    return adjustedHSV
  }
  
  
  /// This will 'pass through', returning `self` if `modification` is `nil`
  public func contrastColour(modification: ColourModification?) -> Self {
    guard let modification else { return self }
    
    return self.contrastColour(
      strength: modification.strength,
      purpose: modification.purpose,
      chroma: modification.chroma
    )
  }
}
