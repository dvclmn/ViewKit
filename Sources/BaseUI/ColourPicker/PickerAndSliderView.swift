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
  let size: CGFloat
  let thumbSize: CGFloat

  public init(
    _ colour: Binding<HSVColour>,
    size: CGFloat = 100,
    thumbSize: CGFloat = 15
  ) {
    self._colour = colour
    self.size = size
    self.thumbSize = thumbSize
  }

  public var body: some View {

    //    GeometryReader { proxy in
    //      let size = proxy.size

    ZStack {
      /// Square gradient area
      PickerSquare(hue: colour.hue)
        .gesture(drag(in: CGSize(fromLength: size)))

    }
    .frame(width: size, height: size)
    //    .viewSize(
    //      capture: .size,
    //      mode: .debounce(0.4),
    //      isEnabled: true,
    //      valueOutput: { viewSize = $0 }
    //    )

    //    }
    //    .aspectRatio(1, contentMode: .fit)
    //      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    .clipShape(.rect(cornerRadius: Styles.sizeSmall))
    .overlay {

      /// Thumb
      Circle()
        .strokeBorder(.white.opacity(0.2), lineWidth: 1)
        .background(Circle().fill(.gray))
        .frame(width: thumbSize, height: thumbSize)
        .position(
          
        )  // y is inverted
        .allowsHitTesting(false)
    }

  }
}
extension SquareColourPicker {
  
  private var thumbPosition: CGPoint {
    CGPoint(
      x: colour.saturation * size,
      y: (1 - colour.brightness) * size
    )
  }

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
