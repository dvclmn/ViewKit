//
//  WaveShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

/// **Phase** – where am I in the cycle? (radians)
/// **Waveform** – how does value map to phase?
/// **Frequency** – how fast phase advances
/// **Amplitude** – how large the output is
/// **Domain** – what variable drives phase (time, space, index)
public protocol WaveShaped {
  var frequency: Double { get }
  var amplitude: Double { get }
  var phase: Double { get }  // phase offset, in cycles
  var waveform: Waveform { get }
}
