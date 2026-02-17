//
//  ColourPickerExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import ColourKit
import SwiftUI

struct ColourPickerExample: View {
  @State private var primary: RGBColour = .init(red: 0.1, green: 0.3, blue: 0.8)
  @State private var secondary: RGBColour? = .init(red: 0.7, green: 0.2, blue: 0.6, alpha: 0.2)
  @State private var components: ColourPickerComponents = .all
  var body: some View {

    Form {
      Section("Dual Colour") {
        ColourPicker(
          primary: $primary,
          secondary: $secondary,
          components: components
        )
      }
      Section("Colour") {
        ColourPicker(
          primary: $primary,
          components: components
        )
      }
      Section("Other") {
        QuickSlider("Value", value: .constant(0.5), range: 0...2)
        Toggle("Check", isOn: .constant(false))
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
