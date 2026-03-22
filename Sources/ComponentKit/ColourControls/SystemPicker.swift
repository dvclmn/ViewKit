//
//  SystemPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/3/2026.
//

import BasePrimitives
import LayoutKit
import SwiftUI

public struct SystemColourPicker: View {
  @Environment(\.self) private var envSelf

  @State private var localGridLineColour: Color
  //  @State private var localGridLineColour: Color = .secondary
  //  @State private var did​Load​Initial​Grid​Line​Colour: Bool = false

  @Binding var colour: RGBColour
  var opacity: Binding<Double>?
//  @Binding var opacity: Double?
  //  let showsOpacitySlider: Bool

  public init(
    colour: Binding<RGBColour>,
    opacity: Binding<Double>? = nil
//    opacity: Binding<Double?> = .constant(nil)
  ) {
    self._localGridLineColour = State(initialValue: colour.wrappedValue.toColour)
    //    self.did​Load​Initial​Grid​Line​Colour = did​Load​Initial​Grid​Line​Colour
    self._colour = colour
    self.opacity = opacity
  }

  public var body: some View {

    ColorPicker("Line Colour", selection: $localGridLineColour, supportsOpacity: false)

      .task(id: localGridLineColour) {
        //        guard did​Load​Initial​Grid​Line​Colour else { return }
        colour = RGBColour(
          colour: localGridLineColour,
          environment: envSelf,
          name: nil
        )
        //        store.setPref(
        //          \.gridLines.colour,
        //          value:
        //            RGBColour(
        //              colour: localGridLineColour,
        //              environment: envSelf,
        //              name: nil
        //            )
        //        )
      }
    //      .task(id: did​Load​Initial​Grid​Line​Colour) {
    //        if !did​Load​Initial​Grid​Line​Colour {
    //          localGridLineColour = colour.toColour
    //          //          localGridLineColour = store.preferences.gridLines.colour.toColour
    //          did​Load​Initial​Grid​Line​Colour = true
    //        }
    //      }

    if let opacity {
      //    if showsOpacitySlider {
      QuickSlider(
        "Opacity",
        value: opacity,
        //        value: Binding(store.$preferences.gridLines.opacity).toBindingDouble,
        range: .unitRange
      )
      .formatValue(.percent)
    }

  }
}
