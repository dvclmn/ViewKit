//
//  RGBAConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

public protocol RGBAConvertible {
  init(r: Double, g: Double, b: Double, a: Double, name: String?)
}

extension Color: RGBAConvertible {
  /// Important: Assumes `SwiftUI/RGBColorSpace/sRGB` colour space
  public init(r: Double, g: Double, b: Double, a: Double, name: String? = nil) {
    self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
  }
}
