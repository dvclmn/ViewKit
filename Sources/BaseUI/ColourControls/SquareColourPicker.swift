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
  @Environment(\.controlSize) private var controlSize

  @State private var viewSize: CGSize?
  @State private var dragPosition: CGPoint = .zero
  @GestureState private var isDragging = false

  @Binding var colour: RGBColour

  public init(
    _ colour: Binding<RGBColour>,
  ) {
    self._colour = colour
  }

  public var body: some View {
    // MARK: - Square Gradient area

    PickerSquare(hue: colour.toHSV.hue)
      .clipShape(.rect(cornerRadius: Styles.sizeSmall))
      .viewSize(mode: .debounce(0.1), isEnabled: true) { size in
        viewSize = size
      }
      .padding(insetAmount / 2)
      .frame(width: sizePlusInset, height: sizePlusInset)

      // MARK: - Thumb
      .overlay {
        SliderThumb(diameter: thumbDiameter, shape: .circle)
          .offset(CGSize(fromLength: insetAmount / 2))
          .position(thumbPosition)

      }
      .gesture(drag())

  }
}
extension SquareColourPicker {

  private var thumbDiameter: CGFloat {
    switch controlSize {
      case .large: 18
      case .small: 12
      default: 16
    }
  }

  private var sizePlusInset: CGFloat? {
    viewSize.map { $0.width + insetAmount }
    //    size + insetAmount
  }
  //  private var sizeMinusInset: CGFloat { size - insetAmount }
  private var insetAmount: CGFloat {
    thumbDiameter / 2
  }

  private var colourHSV: HSVColour { colour.toHSV }

  /// y is inverted
  private var thumbPosition: CGPoint {
    guard let viewSize else { return .zero }
    return CGPoint(
      x: colourHSV.saturation * viewSize.width,
      //      x: colour.saturation * (sizeMinusInset),
      y: (1 - colourHSV.brightness) * viewSize.width
        //      y: (1 - colour.brightness) * (sizeMinusInset)
    )
  }

  func drag() -> some Gesture {
    //  func drag(in size: CGSize) -> some Gesture {
    DragGesture(minimumDistance: 0)
      .updating($isDragging) { _, state, _ in state = true }
      .onChanged { value in

        guard let viewSize else { return }
        let location = value.location
        //        let location = value.location + (insetAmount / 2)

        let clampedX = min(max(location.x, 0), viewSize.width)
        let clampedY = min(max(location.y, 0), viewSize.height)

        let newSat = clampedX / viewSize.width
        let newBrightness = 1 - (clampedY / viewSize.height)  // inverted y axis

        let newHSV = colourHSV.set(hue: nil, saturation: newSat, brightness: newBrightness)
        colour = newHSV.toRGB
        //        colour.toHSV.saturation = clampedX / size.width
        //        colour.toHSV.brightness =
      }
  }

}

extension SquareColourPicker {

}
