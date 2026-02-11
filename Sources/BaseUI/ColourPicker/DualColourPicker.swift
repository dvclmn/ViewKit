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
  //  @Binding var primaryColour: HSVColour
  @Binding var secondaryColour: RGBColour
  //  @Binding var secondaryColour: HSVColour
  //  @Binding var activeColour: ColourLevel
  let kind: ColourModelKind
  //  let activeColour: ColourLevel
  //  let pickerSize: CGFloat

  public init(
    primaryColour: Binding<RGBColour>,
    secondaryColour: Binding<RGBColour>,
    //    activeColour: Binding<ColourLevel>,
    kind: ColourModelKind,
    //    pickerSize: CGFloat = 140
  ) {
    self._primaryColour = primaryColour
    self._secondaryColour = secondaryColour
    //    self._activeColour = activeColour
    self.kind = kind
    //    self.pickerSize = pickerSize
  }

  public var body: some View {

    QuickerPicker(activeColour.wrappedValue.name, selection: activeColour)

    ColourSliderGroup(
      activeColour.wrappedValue.isForeground
        ? $primaryColour
        : $secondaryColour,
      kind: kind
    )
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
