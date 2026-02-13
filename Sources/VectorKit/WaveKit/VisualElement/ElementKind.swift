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
//@MetaEnum
//@AssociatedValues
//@CasePathable
//@dynamicMemberLookup
extension WaveVisualElement {
  public enum ElementKind: String, Sendable, Identifiable, CaseIterable, Codable, Equatable, Hashable {
    /// Dots
    case dotX
    case dotY
    case dotRadius  // *2 for diameter
    case dotHue  // 360° hue shift

    /// Dashes
    case dashLength
    case dashGap
    case dashPhase

    case lineWidth

    public var id: String { rawValue }
  }
}

extension WaveVisualElement.ElementKind {
  public var name: String {
    switch self {
      case .dotX: "Dot X"
      case .dotY: "Dot Y"
      case .dotRadius: "Dot Radius"
      case .dotHue: "Dot Hue"
      case .dashLength: "Dash Length"
      case .dashGap: "Dash Gap"
      case .dashPhase: "Dash Phase"
      case .lineWidth: "Line Width"
    }
  
  }
  
  package func sanitise(_ v: Double) -> Double {
    switch self {
      case .dotRadius, .lineWidth, .dashLength, .dashGap:
        return max(0, v)

      case .dotHue:
        // keep in [0, 360)
        let x = v.truncatingRemainder(dividingBy: 360)
        return x < 0 ? x + 360 : x

      case .dashPhase, .dotX, .dotY:
        return v
    }
  }
}

//extension WaveVisualElement.ElementKind {
//  /// A single source of truth for "which case key path belongs to this meta case"
//  var doubleCase: CaseKeyPath<WaveVisualElement, Double> {
//    switch self {
//      case .dotX: \.dotX
//      case .dotY: \.dotY
//      case .dotRadius: \.dotRadius
//      case .dotHue: \.dotHue
//      case .dashLength: \.dashLength
//      case .dashGap: \.dashGap
//      case .dashPhase: \.dashPhase
//    }
//  }
//}

//extension WaveVisualElement {
//  public subscript() -> WaveVisualElement {
//
//  }
//}

/// Some examples of how a visual element might be moved around
//extension WaveVisualElement.Meta {
//  public static func example(_ wave: ConfiguredWave) ->
//}
