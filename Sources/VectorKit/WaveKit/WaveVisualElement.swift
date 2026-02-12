//
//  WaveVisualElement.swift
//  BaseDemos
//
//  Created by Dave Coleman on 12/2/2026.
//

import CasePaths
import CoreTools
import Foundation

/// I think now being CasePathable, this is essentially the new `SampleState`?
@MetaEnum
@AssociatedValues
@CasePathable
@dynamicMemberLookup
public enum WaveVisualElement: Sendable {
  /// Dots
  case dotX(Double)
  case dotY(Double)
  case dotRadius(Double)  // *2 for diameter
  case dotHue(Double)  // 360 hue shift

  /// Dashes
  case dashLength(Double)
  case dashGap(Double)
  case dashPhase(Double)
}

extension WaveVisualElement.Meta {
  /// A single source of truth for "which case key path belongs to this meta case"
  var doubleCase: CaseKeyPath<WaveVisualElement, Double> {
    switch self {
      case .dotX: \.dotX
      case .dotY: \.dotY
      case .dotRadius: \.dotRadius
      case .dotHue: \.dotHue
      case .dashLength: \.dashLength
      case .dashGap: \.dashGap
      case .dashPhase: \.dashPhase
    }
  }
}

//extension WaveVisualElement {
//  public subscript() -> WaveVisualElement {
//
//  }
//}

/// Some examples of how a visual element might be moved around
//extension WaveVisualElement.Meta {
//  public static func example(_ wave: ConfiguredWave) ->
//}
