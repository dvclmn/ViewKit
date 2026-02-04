//
//  Model+WaveParameter.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 4/11/2024.
//

import CoreTools
import Foundation

@CaseDetection
public enum WaveAttribute<T: WaveFloat>: String, Sendable, CaseIterable, Identifiable {

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

  public var defaultValue: T {
//  public var defaultValue: Float {
    switch self {
      case .amplitude: 20
      case .frequency: 1
      case .phase: 0
      case .noise: 0
      case .cycles: 2
    }
  }
  public var defaultRange: ClosedRange<T> {
    switch self {
      case .amplitude: 0...20
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

  //  public var keyPath: WritableKeyPath<WaveLegacy, SmoothedProperty> {
  //    switch self {
  //      case .amplitude: \.amplitudeSmoothed
  //      case .frequency: \.frequencySmoothed
  //      case .phase: \.phaseOffsetSmoothed
  //      case .noise: \.noiseSmoothed
  //
  //    }
  //  }

  //  @MainActor
  //  public var displayedKeyPath: WritableKeyPath<WaveProperties.Engine, CGFloat> {
  //    switch self {
  //      case .frequency: \.displayedFrequency
  //      case .amplitude: \.displayedAmplitude
  //      case .noise: \.displayedNoise
  //      case .phaseOffset: \.displayedPhaseOffset
  //    }
  //  }
  //
  ////  @MainActor
  //  public var targetKeyPath: WritableKeyPath<WaveProperties.Engine, CGFloat> {
  //    switch self {
  //      case .frequency: \.targetFrequency
  //      case .amplitude: \.targetAmplitude
  //      case .noise: \.targetNoise
  //      case .phaseOffset: \.targetPhaseOffset
  //    }
  //  }

//  public var range: ClosedRange<T> {
//    switch self {
//      case .amplitude: 0.01...60
//      case .frequency: 0.01...20
//      //      case .cyclesAcross: 0.1...10.0
//      case .phase: 0...twoPi()
//      case .noise: 0...4
//    }
//  }

  //  var unitOfMeasurement: ValueUnits {
  //    switch self {
  //        /// Typically 0.0-1.0
  //      case .amplitude: .normalised
  //
  //        /// Cycles per second
  //      case .frequency: .hertz
  //
  //        /// Angular position in wave cycle
  //      case .phase: .radians
  //
  //        /// Noise magnitude typically `0.0-1.0`
  //      case .noise: .normalised
  //    }
  //  }
}
//public var twoPi: CGFloat { .pi * 2 }
