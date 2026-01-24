//
//  AnotherPickerDualColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

public struct DualColourPicker: View {
  @Binding var primaryColour: HSVColour
  @Binding var secondaryColour: HSVColour
  let activeColour: ColourLevel
  let pickerSize: CGFloat

  public init(
    primaryColour: Binding<HSVColour>,
    secondaryColour: Binding<HSVColour>,
    activeColour: ColourLevel,
    pickerSize: CGFloat = 140
  ) {
    self._primaryColour = primaryColour
    self._secondaryColour = secondaryColour
    self.activeColour = activeColour
    self.pickerSize = pickerSize
  }

  public var body: some View {

    AnotherColourPicker(
      colour: activeColour.isForeground
        ? $primaryColour
        : $secondaryColour,
      pickerSize: pickerSize
    )

  }
}
