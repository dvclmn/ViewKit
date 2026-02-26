//
//  GridGeometryView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/2/2026.
//

import CoreTools
import SwiftUI

public struct GridGeometryView<Content: View>: View {

  let dimensions: GridDimensions
  let content: Content

  public init(
    dimensions: GridDimensions,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.dimensions = dimensions
    self.content = content()
  }

  public var body: some View {
    content

      /// This provides the environment with `unitSize`
      .setCharacterSize(mode: .debounce(0.2))

      /// This provides the environment with `viewportRect`
      .viewportCapture(mode: .debounce(0.2), showsIndicator: true)

      .environment(\.gridDimensions, dimensions)
  }
}
