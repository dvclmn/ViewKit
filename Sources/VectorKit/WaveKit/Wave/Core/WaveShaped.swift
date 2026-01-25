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
  var frequency: CGFloat { get }
  var amplitude: CGFloat { get }
  var phase: CGFloat { get }  // phase offset, in cycles
  var waveform: Waveform { get }
}
