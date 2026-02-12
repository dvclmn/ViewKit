//
//  WaveVisualElement.swift
//  BaseDemos
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

import VectorKit
import CoreTools
import CasePaths

/// I think now being CasePathable, this is essentially the new `SampleState`?
@MetaEnum
@CasePathable
@dynamicMemberLookup
public enum WaveVisualElement: Sendable {
  /// Dots
  case dotX(Double)
  case dotY(Double)
  case dotRadius(Double) // *2 for diameter
  case dotHue(Double) // 360 hue shift
  
  /// Dashes
  case dashLength(Double)
  case dashGap(Double)
  case dashPhase(Double)
}

/// Some examples of how a visual element might be moved around
extension WaveVisualElement.Meta {
  public static func example(_ wave: ConfiguredWave) ->
}
