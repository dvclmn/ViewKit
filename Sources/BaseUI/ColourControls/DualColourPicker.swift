//
//  AnotherPickerDualColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

/// Presents both a Square Picker, and RGB/HSV Sliders
public struct DualColourPicker: View {
  @Environment(\.activeColour) private var activeColour

  @Binding var primaryColour: RGBColour
  @Binding var secondaryColour: RGBColour

  /// Note: this also is represented in the Env, just like `activeColour`,
  /// could consider moving it to there, not sure
  let kind: ColourModelKind
  let components: ColourPickerComponents

  public init(
    primaryColour: Binding<RGBColour>,
    secondaryColour: Binding<RGBColour>,
    kind: ColourModelKind,
    components: ColourPickerComponents
  ) {
    self._primaryColour = primaryColour
    self._secondaryColour = secondaryColour
    self.kind = kind
    self.components = components
  }

  public var body: some View {

    QuickerPicker(activeColour.wrappedValue.name, selection: activeColour)

    ColourPicker(
      colour: .colourBinding(
        $primaryColour,
        $secondaryColour,
        level: activeColour.wrappedValue
      ),
      components: components
    )
    //    ColourSliderGroup(
    //      activeColour.wrappedValue.isForeground
    //        ? $primaryColour
    //        : $secondaryColour,
    //      kind: kind
    //    )
  }
}

//public struct DualRGBPicker: View {
//  @Binding var primaryColour: RGBColour
//  @Binding var secondaryColour: RGBColour
//  @Binding var activeColour: ColourLevel
//  //  let activeColour: ColourLevel
//
//  public init(
//    primaryColour: Binding<RGBColour>,
//    secondaryColour: Binding<RGBColour>,
//    activeColour: Binding<ColourLevel>,
//  ) {
//    self._primaryColour = primaryColour
//    self._secondaryColour = secondaryColour
//    self._activeColour = activeColour
//  }
//
//  public var body: some View {
//
//    QuickerPicker(activeColour.name, selection: $activeColour)
//
//    RGBColourSliders(
//      colour: activeColour.isForeground
//        ? $primaryColour
//        : $secondaryColour,
//    )
//  }
//}
