//
//  PickerAndSliderView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI
import ColourKit

struct SquareColourPicker: View {
//  @Environment(AppHandler.self) private var store
  
  
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
  var body: some View {
    
    GeometryReader { proxy in
      let size = proxy.size
      
      ZStack {
        /// Square gradient area
        PickerSquare(colour: <#T##Binding<HSVColour>#>)
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
extension SquareColourPicker {
  
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
  
}
