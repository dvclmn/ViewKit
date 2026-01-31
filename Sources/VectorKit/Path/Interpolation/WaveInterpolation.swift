//
//  WaveInterpolation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import CasePaths
import CoreTools
import SwiftUI

/// Defines the interpolation method for creating smooth paths from discrete points
/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
@MetaEnum
@CasePathable
public enum WaveInterpolation: Sendable, Equatable, Codable, Hashable, Identifiable {
  case linear
  case cubic
  case quadratic
  case catmullRom(CatmullRom.SplineVariant)

  public var id: String {
    switch self {
      case .linear: "linear"
      case .cubic: "cubic"
      case .quadratic: "quadratic"
      case .catmullRom(let variant): "catmullRom.\(variant.rawValue)"
    }
  }
  public var name: String {
    switch self {
      case .catmullRom: "Catmull-Rom"
      default: self.meta.name
    }
  }
}
