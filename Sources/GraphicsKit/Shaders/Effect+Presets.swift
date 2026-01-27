//
//  Effect+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

extension ShaderEffect {
  public static let chromaticPresetA: ShaderEffect = .chromaticAberration(
    r: 0.3,
    b: 0.2,
    strength: 0.5
  )
}
