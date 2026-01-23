//
//  SquarePickerExample.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SwiftUI
import ColourKit

struct HSVPickerExample: View {
  @State private var hue: Double = 0.6
  @State private var saturation: Double = 1.0
  @State private var brightness: Double = 1.0
  
  var body: some View {
    VStack {
      ColourSquarePicker(
        hue: hue,
        saturation: $saturation,
        brightness: $brightness
      )
      .frame(width: 200, height: 200)
      
      Slider(value: $hue, in: 0...1)
        .padding()
      
      RoundedRectangle(cornerRadius: 8)
        .fill(currentColour.toColour)
        .frame(height: 50)
        .padding()
    }
  }
}

extension HSVPickerExample {
  var currentColour: HSVColour {
    HSVColour(
      hue: hue,
      saturation: saturation,
      brightness: brightness)
  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  HSVPickerExample()
}
#endif
