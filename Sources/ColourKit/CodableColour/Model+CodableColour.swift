//
//  Model+CodableColour.swift
//  Colour Library
//
//  Created by Dave Coleman on 3/9/2025.
//

/// `Color` can *take in* HSV values
/// `Color.Resolved` can *give* only RGB

// Credit to Natalia Panferova and Matthaus Woolard of
// https://nilcoalescing.com/blog/EncodeAndDecodeSwiftUIColor/

import NSUI
import SwiftUI

public typealias Colour = CodableColour
public enum CodableColour: Codable, Equatable, Hashable, Sendable {
  case hex(String)
  case rgb(RGBColour)
  case rgbRaw(r: Double, g: Double, b: Double)
  case hsv(HSVColour)
  case hsvRaw(h: Double, s: Double, v: Double)
  case system(SystemColour)
  case mix(
    SystemColour,
    SystemColour,
    Double = 0.5
  )
}
