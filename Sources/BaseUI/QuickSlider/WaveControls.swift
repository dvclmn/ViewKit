//
//  WaveControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI
import VectorKit

public struct WaveControls: View {
  @Binding var wave: Wave
  let ranges: (WaveAttribute) -> ClosedRange<CGFloat>?
  
  public init(
    wave: Binding<Wave>,
    ranges: @escaping (WaveAttribute) -> ClosedRange<CGFloat>? = { _ in nil }
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
