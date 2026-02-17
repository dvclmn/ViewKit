//
//  AnotherPickerDualColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

/// Presents both a Square Picker, and RGB/HSV Sliders
public struct ColourPicker: View {
  @Environment(\.activeColour) private var activeColour
  @Environment(\.activeColourModel) private var activeColourModel

  @Binding var primaryColour: RGBColour
  @Binding var secondaryColour: RGBColour?

  /// Note: this also is represented in the Env, just like `activeColour`,
  /// could consider moving it to there, not sure
  //  let kind: ColourModelKind
//  let components: ColourPickerComponents
  @State private var components: ColourPickerComponents
  
  public init(
    primary: Binding<RGBColour>,
    secondary: Binding<RGBColour?> = .constant(nil),
    //    kind: ColourModelKind,
    components: ColourPickerComponents
  ) {
    self._primaryColour = primary
    self._secondaryColour = secondary
    //    self.kind = kind
    self._components = State(initialValue: components)
  }

  public var body: some View {

    if secondaryColour != nil {
      QuickerPicker(activeColour.wrappedValue.name, selection: activeColour)
    }

    VStack {
      ToggleButtonGroup(components: $components)
        .frame(maxWidth: .infinity, alignment: .trailing)
      
      if components.contains(.square) {
        SquareColourPicker($primaryColour)
      }
      
      if components.contains(.sliders) {
        ColourSliders($primaryColour)
      }
      
      if components.isEmpty {
        StateView("No components specified")
          .controlSize(.small)
      }
    }
    
//    ColourPickerInternal(
//      colour: .colourBinding(
//        $primaryColour,
//        $secondaryColour,
//        level: activeColour.wrappedValue
//      ),
//      components: components
//    )
  }
}
