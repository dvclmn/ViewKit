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

  @State private var hsvLocal: HSVColour

  @State private var viewSize: CGSize?
  @State private var dragPosition: CGPoint = .zero
  @GestureState private var isDragging = false

  @Binding var colour: RGBColour

  public init(
    _ colour: Binding<RGBColour>,
  ) {
    self._colour = colour
    self._hsvLocal = State(initialValue: colour.wrappedValue.toHSV)
  }

  public var body: some View {
    PickerSquare(hue: colour.toHSV.hue)
      .aspectRatio(1, contentMode: .fit)

      .clipShape(.rect(cornerRadius: Styles.sizeSmall))
      .viewSize(mode: .debounce(0.1), isEnabled: true) { size in
        viewSize = size
      }
      //      .padding(insetAmount / 2)
      //      .frame(width: sizePlusInset, height: sizePlusInset)

      // MARK: - Thumb
      .overlay {
        SliderThumb(diameter: thumbDiameter, shape: .circle)
          //          .offset(CGSize(fromLength: insetAmount / 2))
          .position(thumbPosition)

      }

      .gesture(drag(), including: .gesture)

      .task(id: colour) {
        let newHSV = colour.toHSV
        if newHSV.brightness == 0 {
          /// preserve hsv.saturation (and hue) when colour is black
          hsvLocal.brightness = 0
        } else {
          hsvLocal = newHSV
        }
      }

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

  private var colourHSV: HSVColour { colour.toHSV }

  /// y is inverted
  //  private var thumbPosition: CGPoint {
  //    guard let viewSize else { return .zero }
  //
  //    let x = colourHSV.saturation * viewSize.width
  //    let y = (1 - colourHSV.brightness) * viewSize.width
  //    return CGPoint(
  //      x: max(0, x),
  //      y: max(0, y)
  //    )
  //  }

  private var thumbPosition: CGPoint {
    guard let viewSize else { return .zero }
    let x = CGFloat(hsvLocal.saturation) * viewSize.width
    let y = (1 - CGFloat(hsvLocal.brightness)) * viewSize.height
    return CGPoint(
      x: min(max(0, x), viewSize.width),
      y: min(max(0, y), viewSize.height)
    )
  }

  func drag() -> some Gesture {

    DragGesture(minimumDistance: 0)
      .updating($isDragging) { _, state, _ in state = true }
      .onChanged { value in

        guard let viewSize else { return }
        let location = value.location

        let clampedX = min(max(location.x, 0), viewSize.width)
        let clampedY = min(max(location.y, 0), viewSize.height)

        hsvLocal.saturation = Double(clampedX / viewSize.width)
        hsvLocal.brightness = Double(1 - (clampedY / viewSize.height))
        // (optional) hsv.hue stays as-is

        colour = hsvLocal.toRGB

        //        let newSat = clampedX / viewSize.width
        //        let newBrightness = 1 - (clampedY / viewSize.height)  // inverted y axis

        //        let newHSV = colourHSV.set(hue: nil, saturation: newSat, brightness: newBrightness)
        //        colour = newHSV.toRGB
      }
  }

}

extension SquareColourPicker {

}
