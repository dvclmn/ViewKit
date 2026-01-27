//
//  Effect+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

extension ShaderEffect {
  public static let chromaticPresetA: ShaderEffect = .chromaticAberration(
    r: -1.8,
    b: 2.4,
    strength: 2.0,
    radialStrength: 0.5,
    center: CGPoint(x: 30, y: 60)
  )
}
