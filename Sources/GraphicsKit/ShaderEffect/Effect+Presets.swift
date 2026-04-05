//
//  Effect+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

extension ShaderEffect {
  public static let chromaticPresetA: ShaderEffect = .chromaticAberration(
    strength: 1.6,
    radialStrength: 3.0,
  )
  
  public static let chromaticSubtle: ShaderEffect = .chromaticAberration(
    strength: 0.95,
    radialStrength: 1.5,
  )
  
  public static let fisheyePresetA: ShaderEffect = .fisheye(
    origin: CGPoint(200, 300),
    radius: 10,
    strength: 2
  )
  
  public static let psychPresetA: ShaderEffect = .psych(time: Date.now.timeIntervalSinceReferenceDate)
}
