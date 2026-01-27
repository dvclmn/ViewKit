//
//  WaveInterpolation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
public enum WaveInterpolation: String, Sendable, Equatable, Codable, CaseIterable, Identifiable {
  case catmullRom
  case linear
  case cubic
  
  public var id: String { rawValue }
  
  public var name: String {
    switch self {
      case .catmullRom: "Catmull-Rom"
      default: rawValue.capitalized
    }
  }
}

/// Thinking through what is happening in the Canvas for BreathingWave, as this will
/// help as I come up with path-generation for these
/// - Iterates through a sample count. It's interesting, this just purely iterates over
/// an `Int`, just to do 'anything' x-amount of times
/// -

//extension PathStyle {
//  public init(from waveInterpolation: WaveInterpolation) {
//    self =
//    switch waveInterpolation {
//      case .linear: .line
//      case .cubic, .catmullRom: .smooth
//    }
//  }
//}
