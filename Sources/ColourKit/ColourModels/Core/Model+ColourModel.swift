//
//  Model+Colours.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import CoreTools
import SwiftUI

public protocol ColourModel: Codable, Equatable, Identifiable {
  var colourSpace: Color.RGBColorSpace { get }
  var id: UUID { get }
  var name: String? { get }
  var alpha: Double { get set }
  mutating func opacity(_ opacity: Double)
  static func gray(_ brightness: Double, alpha: Double) -> Self
}

extension ColourModel {
  public mutating func opacity(_ opacity: Double) { alpha = opacity }
  public var colourSpace: Color.RGBColorSpace { .sRGB }
  public var nsColourSpace: NSColorSpace { .deviceRGB }
}

@CaseDetection
public enum ColourModelKind: String, Hashable, Codable, Sendable {
  case rgb
  case hsv
}
