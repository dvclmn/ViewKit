//
//  PickerAndSliderView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI

public struct SquareColourPicker: View {
  @State private var dragPosition: CGPoint = .zero
  @GestureState private var isDragging = false

  @Binding var colour: HSVColour

  public init(_ colour: Binding<HSVColour>) {
    self._colour = colour
  }
  
  public var body: some View {

    GeometryReader { proxy in
      let size = proxy.size

      ZStack {
        /// Square gradient area
        PickerSquare(hue: colour.hue)
          .gesture(drag(in: size))

        /// Thumb
        Circle()
          .strokeBorder(.white, lineWidth: 2)
          .background(Circle().fill(.black))
          .frame(width: 16, height: 16)
          .position(
            x: colour.saturation * size.width,
            y: (1 - colour.brightness) * size.height
          )  // y is inverted
          .allowsHitTesting(false)
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .clipShape(.rect(cornerRadius: Styles.sizeSmall))

  }
}
extension SquareColourPicker {

  func drag(in size: CGSize) -> some Gesture {
    DragGesture(minimumDistance: 0)
      .updating($isDragging) { _, state, _ in state = true }
      .onChanged { value in
        let location = value.location

        let clampedX = min(max(location.x, 0), size.width)
        let clampedY = min(max(location.y, 0), size.height)

        colour.saturation = clampedX / size.width
        colour.brightness = 1 - (clampedY / size.height)  // inverted y axis
      }
  }

}

extension SquareColourPicker {

}
