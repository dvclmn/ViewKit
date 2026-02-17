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
  @Environment(\.hsvPrimaryRepresentation) private var hsvPrimaryRepresentation

  //  @State private var hsvPrimaryRepresentation: HSVColour

  @State private var viewSize: CGSize?
  @State private var dragPosition: CGPoint = .zero
  @GestureState private var isDragging = false

  @Binding var colour: RGBColour

  public init(
    _ colour: Binding<RGBColour>,
  ) {
    self._colour = colour
    //    self._hsvPrimaryRepresentation = State(initialValue: colour.wrappedValue.toHSV)
  }

  public var body: some View {

    Group {
      if let bindingHSV = hsvPrimaryRepresentation {
        PickerSquare(hue: bindingHSV.wrappedValue.hue)
          .aspectRatio(1, contentMode: .fit)

          .clipShape(.rect(cornerRadius: Styles.sizeSmall))
          .viewSize(mode: .debounce(0.1), isEnabled: true) { size in
            viewSize = size
          }

          // MARK: - Thumb
          .overlay {
            SliderThumb(diameter: thumbDiameter, shape: .circle)
              .position(thumbPosition)
          }

          .gesture(drag(), including: .gesture)

          .task(id: colour) {
            bindingHSV.wrappedValue = colour.toHSV(preservingHueFrom: bindingHSV.wrappedValue)
            //        let newHSV = colour.toHSV
            //
            //        if newHSV.brightness == 0 || newHSV.saturation == 0 {
            //          /// hue is undefined here; keep existing hue
            //          hsvLocal.saturation = newHSV.saturation
            //          hsvLocal.brightness = newHSV.brightness
            //          hsvLocal.alpha = newHSV.alpha
            //        } else {
            //          hsvLocal = newHSV
            //        }
            //        let newHSV = colour.toHSV
            //        if newHSV.brightness == 0 {
            //          /// preserve hsv.saturation (and hue) when colour is black
            //          hsvLocal.brightness = 0
            //        } else {
            //          hsvLocal = newHSV
            //        }
          }
      }
    }
    .overlay {
      if hsvPrimaryRepresentation == nil {
        StateView("No HSV Representation found in the Environment", icon: .emoji("🌈"))
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

  private var thumbRadius: CGFloat { thumbDiameter / 2 }

  /// How far in from the square edge the thumb centre is allowed to travel.
  /// - If `= thumbRadius`: thumb stays fully inside.
  /// - If `< thumbRadius`: thumb overlaps by (thumbRadius - inset).
  /// - If `> thumbRadius`: thumb stays extra padded from edges.
  private var thumbTravelInset: CGFloat { thumbRadius - 3 }

  private func travelRect(in size: CGSize) -> CGRect {
    CGRect(origin: .zero, size: size).insetBy(dx: thumbTravelInset, dy: thumbTravelInset)
  }

  private var thumbPosition: CGPoint {
    guard let viewSize, let hsv = hsvPrimaryRepresentation?.wrappedValue else { return .zero }
    let rect = travelRect(in: viewSize)

    let x = rect.minX + CGFloat(hsv.saturation) * rect.width
    let y = rect.minY + (1 - CGFloat(hsv.brightness)) * rect.height

    return CGPoint(x: x, y: y)
  }

  func drag() -> some Gesture {

    DragGesture(minimumDistance: 0)
      .updating($isDragging) { _, state, _ in state = true }
      .onChanged { value in

        guard let viewSize, let hsv = hsvPrimaryRepresentation?.wrappedValue else { return }
        let location = value.location

        let rect = travelRect(in: viewSize)

        let x = min(max(location.x, rect.minX), rect.maxX)
        let y = min(max(location.y, rect.minY), rect.maxY)

        let newSat = Double((x - rect.minX) / rect.width)
        let newBrightness = Double(1 - ((y - rect.minY) / rect.height))

        hsvPrimaryRepresentation?.wrappedValue.saturation = newSat
        hsvPrimaryRepresentation?.wrappedValue.brightness = newBrightness

        colour = hsv.toRGB
      }
  }
}
