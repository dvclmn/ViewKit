//
//  BorderBrightness.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

public enum ColourBorderBrightness {
  case dark
  case light
  
  public init(from luminance: Double) {
    self = luminance > 0.86 ? .dark : .light
  }
}
