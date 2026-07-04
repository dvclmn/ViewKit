//
//  SliderCustomThumb.swift
//  BaseComponents
//
//  Created by Dave Coleman on 17/5/2025.
//

import CoreTools
import ViewTools
import SwiftUI

public struct SliderThumb<ThumbShape: InsettableShape>: View {
  @Environment(\.controlSize) private var controlSize

  /// Could probably move this diameter out from here,
  /// have it more adaptable
  let diameter: Double
  let shape: ThumbShape

  let grayShade: Double = 0.9
  public init(
    diameter: Double = 16,
    shape: ThumbShape = .circle,
  ) {
    self.diameter = diameter
    self.shape = shape
  }

  public var body: some View {

    FilledShape(
      shape,
      style: Color(white: 0.2),
//      style: Color(r: grayShade, g: grayShade, b: grayShade),
      strokeColour: strokeGradient().opacity(0.32)
    )

    .shadow(
      color: .black.opacity(0.5),
      radius: 0.9,
      x: 0,
      y: 0.3
    )
    .frameFromLength(diameter, axis: [.horizontal, .vertical])

    //      .allowsHitTesting(false)

  }
}
extension SliderThumb {
  func strokeGradient(
    containsBlack: Bool = false
  ) -> LinearGradient {

    let secondaryColour = containsBlack ? Color.black.opacity(0.7) : Color.clear

    return LinearGradient(
      colors: [.white, secondaryColour],
      startPoint: .top,
      endPoint: .bottom
    )

  }
}
