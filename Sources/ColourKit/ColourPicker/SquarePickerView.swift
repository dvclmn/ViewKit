//
//  Things.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/5/2025.
//

import SharedHelpers
import SwiftUI

@available(macOS 14.0, *)
public struct ColourSquarePicker: View {

  @State private var dragPosition: CGPoint = .zero
  @GestureState private var isDragging = false

  let hue: Double
  @Binding var saturation: Double
  @Binding var brightness: Double

  public init(
    hue: Double,
    saturation: Binding<Double>,
    brightness: Binding<Double>,
  ) {
    self.hue = hue
    self._saturation = saturation
    self._brightness = brightness
  }

  public var body: some View {
    GeometryReader { geo in
      let size = geo.size

      ZStack {
        /// Square gradient area
        SquarePicker()
          .gesture(drag(in: size))

        /// Thumb
        Circle()
          .strokeBorder(.white, lineWidth: 2)
          .background(Circle().fill(.black))
          .frame(width: 16, height: 16)
          .position(
            x: saturation * size.width,
            y: (1 - brightness) * size.height
          )  // y is inverted
          .allowsHitTesting(false)
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .clipShape(.rect(cornerRadius: Styles.sizeSmall))
  }
}

@available(macOS 14.0, *)
extension ColourSquarePicker {

  func drag(in size: CGSize) -> some Gesture {
    DragGesture(minimumDistance: 0)
      .updating($isDragging) { _, state, _ in state = true }
      .onChanged { value in
        let location = value.location

        let clampedX = min(max(location.x, 0), size.width)
        let clampedY = min(max(location.y, 0), size.height)

        saturation = clampedX / size.width
        brightness = 1 - (clampedY / size.height)  // inverted y axis
      }
  }

  @ViewBuilder
  func SquarePicker() -> some View {

    ZStack {
      Rectangle()
        .fill(
          HSVColour(
            hue: hue,
            saturation: 1,
            brightness: 1,
            alpha: 1
          ).toColour
        )

      LinearGradient(
        colors: [.white, .clear],
        startPoint: .leading, endPoint: .trailing
      )
      .blendMode(.screen)

      LinearGradient(
        colors: [.clear, .black],
        startPoint: .top, endPoint: .bottom
      )
      .blendMode(.multiply)
    }
    .compositingGroup()
    .drawingGroup()

  }
}
