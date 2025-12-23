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

//import NSUI
import SwiftUI

//@available(macOS 14.0, *)
public typealias Colour = CodableColour

//@available(macOS 14.0, *)
public enum CodableColour: Codable, Equatable, Hashable, Sendable {
  case hex(String, opacity: Double = 1)
  case rgb(RGBColour)
  case rgbRaw(r: Double, g: Double, b: Double, a: Double = 1)
  case hsv(HSVColour)
  case hsvRaw(h: Double, s: Double, v: Double, a: Double = 1)
  case system(SystemColour, opacity: Double = 1)
  case grey(Double, opacity: Double = 1) // 0 == black, 1 == white
  case mix(
    SystemColour,
    SystemColour,
    Double = 0.5,
    opacity: Double = 1
  )
}
