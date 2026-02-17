//
//  SetHSVRepresentation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

import ColourKit
import SwiftUI

struct HSVRepresentationModifier<Colour: ColourModel & HSVAdjustable>: ViewModifier {

  @State private var hsvPrimaryRepresentation: HSVColour?

  let representation: Colour?
  init(
    representation: Colour?
  ) {
    self.representation = representation
    self._hsvPrimaryRepresentation = State(initialValue: representation?.toHSV)
  }
  func body(content: Content) -> some View {
    content
      .task(id: representation) {
        guard representation is RGBColour, let representation else { return }
        self.hsvPrimaryRepresentation = representation.toHSV
      }

      .environment(\.hsvPrimaryRepresentation, $hsvPrimaryRepresentation)
  }
}
extension View {
  public func setHSVRepresentation<T>(using initialColour: T) -> some View
  where T: ColourModel & HSVAdjustable {
    self.modifier(HSVRepresentationModifier(representation: initialColour))
  }
}
