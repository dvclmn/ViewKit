//
//  WaveControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI
import VectorKit

struct WaveControls: View {
  @Binding var wave: Wave
  let ranges: (WaveAttribute) -> ClosedRange<CGFloat>
  var body: some View {
    
    SliderGroup {
      QuickSlider(
        "Amplitude",
        value: $wave.amplitude,
        range: ranges(.amplitude)
      )
    }
    
  }
}
