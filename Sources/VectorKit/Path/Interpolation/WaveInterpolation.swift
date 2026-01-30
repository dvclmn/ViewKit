import CoreTools
//
//  WaveInterpolation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//
import SwiftUI

/// Defines the interpolation method for creating smooth paths from discrete points
/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
@MetaEnum
public enum WaveInterpolation: Sendable, Equatable, Codable, Hashable {
  case linear
  case cubic
//  case quad
  case catmullRom(CatmullRomConfiguration)

  public var name: String {
    switch self {
      case .catmullRom: "Catmull-Rom"
      default: self.meta.name
    }
  }
}
