//
//  ColourPickerExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import SwiftUI
import ColourKit

struct ColourPickerExample: View {
  @State private var colour: RGBColour = .init(red: 0.1, green: 0.3, blue: 0.8)
  @State private var components: ColourPickerComponents = .all
  var body: some View {
    
    Form {
      Section("Other") {
        QuickSlider("Value", value: .constant(0.5), range: 0...2)
        Toggle("Check", isOn: .constant(false))
      }
      Section("Colour") {
        ColourPicker(
          colour: $colour,
          components: components
        )
      }
    }
    .formStyle(.grouped)
  }
}

extension ColourPickerExample {
  
}
#if DEBUG
#Preview(traits: .size(.normal)) {
  ColourPickerExample()
    .frame(width: 300)
}
#endif
