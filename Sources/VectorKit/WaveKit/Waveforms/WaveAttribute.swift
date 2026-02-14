//
//  Model+WaveParameter.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 4/11/2024.
//

import CoreTools
import Foundation

@CaseDetection
public enum WaveAttribute: String, Sendable, CaseIterable, Identifiable {

  public static var allCases: [Self] { [.amplitude, .frequency, .phase] }

  /// How visually apparent is the oscillation effect. Aka strength
  case amplitude

  /// How rapidly does the oscillation occur. Aka speed
  case frequency

  case phase

  /// How much irregularity is introduced into the overall wave / movement
  case noise

  case cycles

  public var id: String { rawValue }

  public var name: (full: String, abbreviated: String) {
    switch self {
      case .amplitude: ("Amplitude", "Amp")
      case .frequency: ("Frequency", "Freq")
      case .phase: ("Phase Offset", "Phase")
      case .noise: ("Noise", "Noise")
      case .cycles: ("Cycles", "Cycles")
    }
  }

  public var defaultValue: Double {
    //  public var defaultValue: Float {
    switch self {
      case .amplitude: 20
      case .frequency: 1
      case .phase: 0
      case .noise: 0
      case .cycles: 2
    }
  }
  public var defaultRange: ClosedRange<Double> {
    switch self {
      case .amplitude: 0...100
      case .frequency: 0...4
      case .phase: .phaseRange
      case .noise: 0...20
      case .cycles: 0...20
    }
  }

  public var icon: String {
    switch self {
      case .amplitude: "cellularbars"  // lines.measurement.horizontal, speaker.wave.2
      case .frequency: "waveform.path.ecg"
      //      case .phase: "point.forward.to.point.capsulepath"
      case .phase: "eye"  // glowplug, scribble
      case .noise: "dice"  // glowplug, scribble
      case .cycles: "dice"  // glowplug, scribble
    //      case .cyclesAcross: "eye"
    }
  }

  public func get(from wave: ConfiguredWave) -> Double {
    switch self {
      case .amplitude: wave.wave.amplitude
      case .frequency: wave.wave.frequency
      case .phase: wave.wave.phaseRadians
      case .cycles: wave.config.cycles
      case .noise: wave.config.noise
    }
  }

  public func set(_ newValue: Double, on wave: inout ConfiguredWave) {
    switch self {
      case .amplitude: wave.wave.amplitude = newValue
      case .frequency: wave.wave.frequency = newValue
      case .phase: wave.wave.phaseRadians = newValue
      case .cycles: wave.config.cycles = newValue
      case .noise: wave.config.noise = newValue
    }
  }

  public var keyPath: WritableKeyPath<ConfiguredWave, Double> {
    switch self {
      case .amplitude: \.wave.amplitude
      case .frequency: \.wave.frequency
      case .phase: \.wave.phaseRadians
      case .noise: \.config.noise
      case .cycles: \.config.cycles
    }
  }
}
