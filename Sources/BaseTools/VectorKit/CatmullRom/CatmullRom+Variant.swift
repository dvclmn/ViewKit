//
//  CatmullRom+Variant.swift
//  InteractionKit
//
//  Created by Dave Coleman on 1/4/2026.
//

import Foundation

extension CatmullRom {

  /// Parameterisation style controlling how the knot vector is computed.
  ///
  /// The `alpha` value determines how much the physical distance between
  /// points affects the speed of the curve through that section.
  ///
  /// - `.uniform` (`alpha = 0`): ignores distance between points, so each
  ///   segment receives the same amount of parameter space. This is fast and
  ///   simple, but can produce loops when points are unevenly spaced.
  /// - `.centripetal` (`alpha = 0.5`): uses the square root of distance.
  ///   This is the recommended default because it avoids cusps and
  ///   self-intersections for typical drawing input.
  /// - `.chordal` (`alpha = 1`): makes parameter space proportional to
  ///   distance. This can create wider, more relaxed curves around sharp
  ///   direction changes.
  ///
  /// In short: `alpha` handles the geometry of the path, while any separate
  /// tension control would handle the stiffness of the path.
  public enum Variant: String, Codable, Sendable, CaseIterable, Identifiable {
    case uniform
    case centripetal
    case chordal

    public var id: String { rawValue }

    public var alpha: CGFloat {
      switch self {
        case .uniform: 0
        case .centripetal: 0.5
        case .chordal: 1
      }
    }

    public var name: String { self.rawValue.capitalized }

    public var icon: String {
      switch self {
        case .uniform: "equal"
        case .centripetal: "circle.lefthalf.filled"
        case .chordal: "point.topleft.down.curvedto.point.bottomright.up"
      }
    }

  }
}
