//
//  Model+Colours.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import CoreTools
import SwiftUI

public protocol ColourModel: Codable, Equatable {
  var colourSpace: Color.RGBColorSpace { get }
  var name: String? { get }
  var alpha: Double { get set }
  mutating func opacity(_ opacity: Double)
  static func gray(_ brightness: Double, alpha: Double) -> Self
}

// MARK: - Extension methods
extension ColourModel {
  public mutating func opacity(_ opacity: Double) { alpha = opacity }
  public var colourSpace: Color.RGBColorSpace { .sRGB }
  public var nsColourSpace: NSColorSpace { .deviceRGB }
//  public var nsColourSpace: NSColorSpace { .sRGB }
}

@CaseDetection
public enum ColourModelKind {
  case rgb
  case hsv
}
