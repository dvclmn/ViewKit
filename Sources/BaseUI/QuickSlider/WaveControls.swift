//
//  WaveControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI
import VectorKit

public struct WaveControls: View {
  @Binding var wave: FloatWave
  let ranges: (WaveAttribute) -> ClosedRange<Float>?
  
  public init(
    wave: Binding<FloatWave>,
    ranges: @escaping (WaveAttribute) -> ClosedRange<Float>? = { _ in nil }
  ) {
    self._wave = wave
    self.ranges = ranges
  }
  public var body: some View {
    
    SliderGroup {
      QuickSlider(
        "Amplitude",
        value: $wave.amplitude,
        range: ranges(.amplitude) ?? 0...1
      )
      
      QuickSlider(
        "Frequency",
        value: $wave.frequency,
        range: ranges(.frequency) ?? 0...1
      )
      
      QuickSlider(
        "Phase",
        value: $wave.phase,
        range: ranges(.phase) ?? .unitRange
      )
    }
    
  }
}
