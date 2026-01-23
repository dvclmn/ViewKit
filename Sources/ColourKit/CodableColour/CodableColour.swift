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

import SwiftUI

public typealias Colour = CodableColour

public enum CodableColour: Codable, Equatable, Hashable, Sendable, Identifiable {
  case hex(String, opacity: Double = 1)
  case rgb(RGBColour)
  case rgbRaw(r: Double, g: Double, b: Double, a: Double = 1)
  case hsv(HSVColour)
  case hsvRaw(h: Double, s: Double, v: Double, a: Double = 1)
  case system(SystemColour, opacity: Double = 1)
  case grey(Double, opacity: Double = 1)  // 0 == black, 1 == white
  case mix(
    SystemColour,
    SystemColour,
    Double = 0.5,
    opacity: Double = 1
  )
}

extension CodableColour {
  public var id: Self { self }

  public init?(fromPrimitive primitiveColour: PrimitiveColour) {
    guard let colour = primitiveColour.toSystemColour else { return nil }
    self = CodableColour.system(colour, opacity: 1.0)
  }
  public var name: String {
    switch self {
      case .hex(let string, let opacity):
        "Hex: \(string), Opacity: \(opacity)"

      case .rgb(let rGBColour):
        "RGBColour: \(rGBColour.description)"

      case .rgbRaw(let r, let g, let b, let a):
        "RGB (components): \(r), \(g), \(b), Opacity: \(a)"

      case .hsv(let hSVColour):
        "HSVColour: \(hSVColour.description)"

      case .hsvRaw(let h, let s, let v, let a):
        "HSV (components): \(h), \(s), \(v), Opacity: \(a)"

      case .system(let systemColour, let opacity):
        "System Colour: \(systemColour.name), Opacity: \(opacity)"

      case .grey(let double, let opacity):
        "Grey: \(double), Opacity: \(opacity)"

      case .mix(let systemColour, let systemColour2, let double, let opacity):
        "Mix: \(systemColour.name) + \(systemColour2.name), Amount: \(double), Opacity: \(opacity)"
    }
  }
}
