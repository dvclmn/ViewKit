//
//  Slider+Thumb.swift
//  ViewKit
//
//  Created by Dave Coleman on 17/5/2025.
//

import CoreTools
import ViewTools
import SwiftUI

/// A standalone decorative thumb for controls that draw their own track.
///
/// `QuickSlider` no longer uses this view: custom QuickSlider tracks use the
/// platform AppKit thumb so they retain the native interaction and appearance.
public struct SliderThumb<ThumbShape: InsettableShape>: View {
  let diameter: Double
  let shape: ThumbShape

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
      strokeColour: strokeGradient().opacity(0.32)
    )
    .shadow(
      color: .black.opacity(0.5),
      radius: 0.9,
      x: 0,
      y: 0.3
    )
    .frameFromLength(diameter, axis: [.horizontal, .vertical])
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
