//
//  Model+PatternPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation
import ColourKit

public struct PatternPreset: Sendable {
  let style: PatternStyle
  let config: PatternConfiguration
}

extension PatternPreset {
  public static let opacityCheckerboard = PatternPreset(
    style: .checkerboard,
    config: PatternConfiguration(
      size: 5,
      gap: 2,
      offset: CGSize(width: 0, height: -2),
      primaryColour: .gray,
      secondaryColour: .white
    )
  )
  
}
