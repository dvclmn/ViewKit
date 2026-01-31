//
//  WaveInterpolation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import SwiftUI
import CoreTools
import CasePaths

/// Defines the interpolation method for creating smooth paths from discrete points
/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
@MetaEnum
@CasePathable
public enum WaveInterpolation: Sendable, Equatable, Codable, Hashable, Identifiable {
  case linear
  case cubic
  case catmullRom(CatmullRom.SplineVariant)
  public var id: String {
    switch self {
      case .linear: "linear"
      case .cubic: "cubic"
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
