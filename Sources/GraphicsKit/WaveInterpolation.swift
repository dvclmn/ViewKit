//
//  WaveInterpolation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import CasePaths
import EnumMacros
import InteractionKit
import BasePrimitives
import SwiftUI

/// Defines the interpolation method for creating smooth paths from discrete points
/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
@MetaEnum
@CaseDetection
@CasePathable
@dynamicMemberLookup
public enum WaveInterpolation: Sendable, Equatable, Codable, Hashable, Identifiable, CaseIterable {
  public static let allCases: [WaveInterpolation] = [.linear, .cubic(), .quadratic(), .catmullRom()]
  case linear
  case cubic(tension: CGFloat = 0)
  case quadratic(midpoint: Double = 0.5, cornerBias: Double = 0.5)
  case catmullRom(
    CatmullRom.Variant = .centripetal,
    tension: CGFloat = 0.5,
    samples: Int = 14
  )

  public var id: String {
    switch self {
      case .linear: "linear"
      case .cubic: "cubic"
      case .quadratic: "quadratic"
      case .catmullRom(let variant, _, _): "catmullRom.\(variant.rawValue)"
    }
  }
  public var name: String {
    switch self {
      case .catmullRom: "Catmull-Rom"
      default: self.meta.name
    }
  }

}

extension WaveInterpolation {
  /// Trying out allowing init from a meta enum, for cases with no assoc. values
  //  public init?(fromMeta meta: Self.Meta) {
  //    switch meta {
  //      case .linear: self = .linear
  //      case .cubic: self = .cubic
  //      case .quadratic: self = .quadratic
  //      case .catmullRom: return nil
  //    }
  //  }
}
