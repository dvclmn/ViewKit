//
//  WaveControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI
import VectorKit

public struct WaveControls<T: WaveFloat>: View {
  @Binding var wave: ConfiguredWave
//  @Binding var wave: Wave<T>
  let ranges: (WaveAttribute<T>) -> ClosedRange<T>?
  
  public init(
    wave: Binding<ConfiguredWave>,
//    wave: Binding<Wave<T>>,
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
        range: ranges(.amplitude)?.toDoubleRange ?? .unitRange
      )
      
      QuickSlider(
        "Frequency",
        value: $wave.frequency.toBindingDouble,
        range: ranges(.frequency)?.toDoubleRange ?? .unitRange
      )
      
      QuickSlider(
        "Phase",
        value: $wave.phaseRadians.toBindingDouble,
        range: ranges(.phase)?.toDoubleRange ?? .unitRange
      )
      
      Divider()
      
      /// Might make this one optional?
      QuickSlider(
        "Cycles",
        value: $wave.config.cycles,
        range: ranges(.cycles)?.toDoubleRange ?? .unitRange,
        step: 1
      )
      .stepStyle(.stepper)
    }
    
  }
}
