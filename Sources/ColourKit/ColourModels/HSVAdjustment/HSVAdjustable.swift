//
//  Contrastable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

public protocol HSVAdjustable {
  var toHSV: HSVColour { get }
  init(fromHSV hsv: HSVColour)

  func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose,
    chroma: ColourChroma,
  ) -> Self

  func contrastColour(modification: ColourModification?) -> Self
}

extension HSVAdjustable {

  /// Adjustment by delta. Increase/decrease by amount provided.
  /// `0` =  no adjustment
  public func adjust(
    hue: Double,
    saturation: Double,
    brightness: Double
  ) -> Self {
    var hsv = self.toHSV
    hsv.hue += hue
    hsv.saturation += saturation
    hsv.brightness += brightness

    return Self(fromHSV: hsv)
  }

  public func adjust(
    by adjustment: HSVAdjustment
  ) -> Self {
    var hsv = self.toHSV

    if let dh = adjustment.hue { hsv.hue += dh }
    if let ds = adjustment.saturation { hsv.saturation += ds }
    if let dv = adjustment.brightness { hsv.brightness += dv }

    return Self(fromHSV: hsv)
  }

  /// Set a new value, returns new instance
  /// If value is `nil`, that property doesn't get touched
  public func set(
    hue: Double?,
    saturation: Double?,
    brightness: Double?
  ) -> Self {
    var hsv = self.toHSV
    if let hue {
      hsv.hue = hue
    }
    if let saturation {
      hsv.saturation = saturation
    }
    if let brightness {
      hsv.brightness = brightness
    }
    return Self(fromHSV: hsv)
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

extension HSVAdjustable where Self: LuminanceReadable {

  public func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose = .legibility,
    chroma: ColourChroma = .standard,
  ) -> Self {

    let hsv = self.toHSV

    guard strength.adjustmentStrength > 0 else { return self }

    let adjustment = HSVAdjustment.applyingModifiers(
      for: self,
      strength: strength,
      purpose: purpose,
      chroma: chroma
    )

    let adjustedHSV = hsv.adjust(by: adjustment)
    //    let adjustedHSV = hsv.apply(adjustment: adjustment)

    let adjustedColour = Self(fromHSV: adjustedHSV)

    return adjustedColour

  }
}
