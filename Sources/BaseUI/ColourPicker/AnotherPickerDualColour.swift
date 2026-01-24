//
//  AnotherPickerDualColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

public struct DualHSVPicker: View {
  @Binding var primaryColour: HSVColour
  @Binding var secondaryColour: HSVColour
  @Binding var activeColour: ColourLevel
//  let activeColour: ColourLevel
  let pickerSize: CGFloat

  public init(
    primaryColour: Binding<HSVColour>,
    secondaryColour: Binding<HSVColour>,
    activeColour: Binding<ColourLevel>,
    pickerSize: CGFloat = 140
  ) {
    self._primaryColour = primaryColour
    self._secondaryColour = secondaryColour
    self._activeColour = activeColour
    self.pickerSize = pickerSize
  }

  public var body: some View {

    QuickerPicker(activeColour.name, selection: $activeColour)
      .pickerStyle(.segmented)
    
    AnotherColourPicker(
      colour: activeColour.isForeground
        ? $primaryColour
        : $secondaryColour,
      pickerSize: pickerSize
    )

  }
}

public struct DualRGBPicker: View {
  @Binding var primaryColour: RGBColour
  @Binding var secondaryColour: RGBColour
  @Binding var activeColour: ColourLevel
  //  let activeColour: ColourLevel

  public init(
    primaryColour: Binding<RGBColour>,
    secondaryColour: Binding<RGBColour>,
    activeColour: Binding<ColourLevel>,
  ) {
    self._primaryColour = primaryColour
    self._secondaryColour = secondaryColour
    self._activeColour = activeColour
  }

  public var body: some View {

    QuickerPicker(activeColour.name, selection: $activeColour)
      .pickerStyle(.segmented)

    RGBColourSliders(
      colour: activeColour.isForeground
        ? $primaryColour
        : $secondaryColour,
    )
  }
}
