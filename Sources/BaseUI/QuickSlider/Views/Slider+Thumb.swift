//
//  SliderCustomThumb.swift
//  BaseComponents
//
//  Created by Dave Coleman on 17/5/2025.
//

import CoreTools
import SwiftUI

public struct SliderThumb<ThumbShape: InsettableShape, Value: BinaryFloatingPoint & Sendable>: View {
  @Environment(\.controlSize) private var controlSize

  let diameter: Value
  let position: CGPoint?
  let shape: ThumbShape

  public init(
    diameter: Value,
    position: CGPoint?,
    shape: ThumbShape = .circle,
  ) {
    self.diameter = diameter
    self.position = position
    self.shape = shape
  }

  public var body: some View {

    if let position {

      FilledShape(
        shape,
        Color.gray,
        strokeColour: strokeGradient().opacity(0.32)
      )

      .shadow(
        color: .black.opacity(0.5),
        radius: 0.9,
        x: 0,
        y: 0.3
      )
      .frameFromLength(diameter, axis: [.horizontal, .vertical])
      .position(position)
      .allowsHitTesting(false)
    }
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
