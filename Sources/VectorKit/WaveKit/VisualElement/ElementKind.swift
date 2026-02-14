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
  @CaseDetection
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

  /// What does each Kind need for it's base value
  /// `dotX` and `dotY`
  /// `WavePlacement` and view size
  ///
  /// `dotRadius`
  /// Needs `WaveStyle/PointStyle`
  ///
  /// `dotHue`
  /// Perhaps needs similar to dotX/Y? It calculates a hue 'mix amount',
  /// spread along the dominant view axis (as per WavePlacement)
  ///
  /// `dashLength`, `dashGap`, `dashPhase` and `lineWidth`
  /// Need `WaveLineStyle`
  public func baseValue(
    index: Double,  // Normalised index
    config: WaveConfiguration,
    viewSize size: CGSize
  ) -> Double {

    switch self {
      case .dotX:
        baseLocation(index, placement: config.placement, viewSize: size).baseX
//        let base: Double
//        if config.placement == .horizontal {
//          base = index.lerp(from: size.width, to: 0)
//
//        } else if config.placement == .vertical {
//          base = size.width / 2
//
//        } else {
//          preconditionFailure("Not yet supported")
//        }
//        return base

      case .dotY:
        baseLocation(index, placement: config.placement, viewSize: size).baseY
//        let base: Double
//        if config.placement == .horizontal {
//          base = size.height / 2
//
//        } else if config.placement == .vertical {
//          base = index.lerp(from: size.height, to: 0)
//
//        } else {
//          preconditionFailure("Not yet supported")
//        }
//        return base

      case .dotRadius:
        config.style.pointStyle.radius

      case .dotHue:
        baseLocation(index, placement: config.placement, viewSize: size).baseY
        
      case .dashLength:

      case .dashGap:

      case .dashPhase:

      case .lineWidth:

    }
  }
  
  private func baseLocation(
    _ index: Double,
    placement: WavePlacement,
    viewSize size: CGSize
  ) -> (baseX: Double, baseY: Double) {
    
    var baseX: Double
    var baseY: Double
    
    switch placement {
      case .horizontal:
        baseX = index.lerp(from: size.width, to: 0)
        /// Establishes a starting point halfway up the view,
        /// in a horizontal line
        baseY = size.height / 2
        
      case .vertical:
        baseY = index.lerp(from: size.height, to: 0)
        /// Establishes a starting point in the centre of the view,
        /// in a vertical line
        baseX = size.width / 2
        
      default: preconditionFailure("Not yet supported")
    }
    
    return (baseX, baseY)
  }

  package func sanitise(_ value: Double) -> Double {
    switch self {
      case .dotRadius, .lineWidth, .dashLength, .dashGap:
        return max(0, value)

      case .dotHue:
        /// keep in [0, 360)
        let x = value.truncatingRemainder(dividingBy: 360)
        return x < 0 ? x + 360 : x

      case .dashPhase, .dotX, .dotY:
        return value
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
