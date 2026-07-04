//
//  Things.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/5/2025.
//

import CoreTools
import ViewTools
import ColourTools
import SwiftUI

struct PickerSquare: View {
  let hue: Double
  var body: some View {

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
