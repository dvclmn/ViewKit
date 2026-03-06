//
//  WaveVisualElement.swift
//  BaseDemos
//
//  Created by Dave Coleman on 12/2/2026.
//

import CasePaths
import EnumMacros
import BasePrimitives
//import CoreTools
import Foundation

/// Might find better solution, but for now this is an easy way to avoid
/// long strung-together guard let statements etc

/// I think now being CasePathable, this is essentially the new `SampleState`?
//@MetaEnum
//@AssociatedValues
//@CasePathable
//@dynamicMemberLookup
//extension WaveVisualElement {
@CaseDetection
public enum VisualElementKind: String, Sendable, Identifiable, CaseIterable, Codable, Equatable, Hashable,
  LabeledItem
{
  /// Dots
  case dotX
  case dotY
  case dotRadius  // *2 for diameter
  case dotHue  // 360° hue shift

  /// Dashes
  //    case dashLength
  case dashGap
  case dashPhase

  case lineWidth

  public var id: String { rawValue }
}
//}

extension VisualElementKind {

  public var name: String {
    switch self {

      case .dotX: "Dot X"
      case .dotY: "Dot Y"
      case .dotRadius: "Dot Radius"
      case .dotHue: "Dot Hue"
      //      case .dashLength: "Dash Length"
      case .dashGap: "Dash Gap"
      case .dashPhase: "Dash Phase"
      case .lineWidth: "Line Width"
    }
  }

  public var icon: IconLiteral {
    switch self {
      case .dotX: "arrow.left.and.right"  // x.axis
      case .dotY: "arrow.up.and.down"  // y.axis
      case .dotRadius: "circle.dotted.circle"
      case .dotHue: "swatchpalette"
      case .dashGap: "directcurrent"  // alternatingcurrent
      case .dashPhase: "clock.arrow.trianglehead.counterclockwise.rotate.90"
      case .lineWidth: "lineweight"
    }
  }
  public var label: QuickLabel { .init(name, icon: icon) }
}

extension VisualElementKind {

  public var operation: WaveOperation {
    //  public func operation(operationOverride: WaveOperation? = nil) -> WaveOperation {
    //  public func operation(override: (() -> WaveOperation)? = nil) -> WaveOperation {
    let base: WaveOperation =
      switch self {
        case .dotX: .addToBase
        case .dotY: .addToBase
        case .dotRadius: .scaleBaseByOnePlusOffset
        case .dotHue: .addToBase
        case .dashGap: .addToBase
        case .dashPhase: .addToBase
        case .lineWidth: .addToBase
      }
    return base
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
    settings: WaveRenderSettings,
    viewSize size: CGSize
  ) -> Double {

    switch self {
      case .dotX:
        baseLocation(index, placement: settings.placement, viewSize: size).baseX

      case .dotY:
        baseLocation(index, placement: settings.placement, viewSize: size).baseY

      case .dotRadius:
        settings.style.pointStyle.radius

      case .dotHue:
        baseLocation(index, placement: settings.placement, viewSize: size).baseY

      case .dashGap:
        settings.style.lineStyle.dashGap

      case .dashPhase:
        settings.style.lineStyle.dashPhase

      case .lineWidth:
        settings.style.lineStyle.lineWidth

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
      case .dotRadius, .lineWidth, .dashGap:
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
