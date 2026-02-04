//
//  WaveControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI
import VectorKit

public struct WaveControls<T: WaveFloat>: View {
  @Binding var wave: Wave<T>
  let ranges: (WaveAttribute<T>) -> ClosedRange<T>?
  
  public init(
    wave: Binding<Wave<T>>,
    ranges: @escaping (WaveAttribute<T>) -> ClosedRange<T>? = { _ in nil }
  ) {
    self._wave = wave
    self.ranges = ranges
  }
  public var body: some View {
    
    SliderGroup {
      QuickSlider(
        "Amplitude",
        value: $wave.amplitude.toBindingDouble,
        range: ranges(.amplitude)?.toDoubleRange ?? 0.0...1.0
      )
      
      QuickSlider(
        "Frequency",
        value: $wave.frequency.toBindingDouble,
        range: ranges(.frequency)?.toDoubleRange ?? 0.0...1.0
      )
      
      QuickSlider(
        "Phase",
        value: $wave.phaseRadians.toBindingDouble,
        range: ranges(.phase)?.toDoubleRange ?? .unitRange
      )
    }
    
  }
}
