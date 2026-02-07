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

  @State private var colourHSV: HSVColour = .white
  
  @Binding var colour: RGBColour
  //  @Binding var colour: HSVColour
  let size: CGFloat
  let thumbSize: CGFloat

  public init(
    _ colour: Binding<RGBColour>,
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
      PickerSquare(hue: colour.toHSV.hue)
        .clipShape(.rect(cornerRadius: Styles.sizeSmall))
        .padding(insetAmount / 2)
        //        .border(Color.green.opacity(0.3))
        .gesture(drag(in: CGSize(fromLength: sizePlusInset)))

    }
    .frame(width: sizePlusInset, height: sizePlusInset)
    //    .border(Color.brown.opacity(0.3))
    .overlay {

      /// Thumb
      Circle()
        .strokeBorder(.white.opacity(0.2), lineWidth: 1)
        .background(Circle().fill(.gray))
        .frame(width: thumbSize, height: thumbSize)
        //        .border(Color.red.opacity(0.3))

        .offset(CGSize(fromLength: insetAmount / 2))
        //        .border(Color.orange.opacity(0.3))

        .position(thumbPosition)
        //        .border(Color.yellow.opacity(0.3))

        .allowsHitTesting(false)
    }
    .task(id: colour) {
      colourHSV = colour.toHSV
    }

  }
}
extension SquareColourPicker {
  private var sizePlusInset: CGFloat { size + insetAmount }
  private var sizeMinusInset: CGFloat { size - insetAmount }
  private var insetAmount: CGFloat {
    thumbSize / 2
    //    size * 0.05
  }

  /// y is inverted
  private var thumbPosition: CGPoint {
    return CGPoint(
      x: colourHSV.saturation * (size),
      //      x: colour.saturation * (sizeMinusInset),
      y: (1 - colourHSV.brightness) * (size)
      //      y: (1 - colour.brightness) * (sizeMinusInset)
    )
  }

  func drag(in size: CGSize) -> some Gesture {
    DragGesture(minimumDistance: 0)
      .updating($isDragging) { _, state, _ in state = true }
      .onChanged { value in
        let location = value.location
        //        let location = value.location + (insetAmount / 2)

        let clampedX = min(max(location.x, 0), size.width)
        let clampedY = min(max(location.y, 0), size.height)

        let newSat = clampedX / size.width
        let newBrightness = 1 - (clampedY / size.height)  // inverted y axis
        let newHSV = colourHSV.set(hue: nil, saturation: newSat, brightness: newBrightness)
        colour = newHSV.toRGB
//        colour.toHSV.saturation = clampedX / size.width
//        colour.toHSV.brightness =
      }
  }

}

extension SquareColourPicker {

}
