//
//  GridSetupModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import CoreTools
import SwiftUI

/// This handles a lot of common setup required for Grid-related domains.
/// - Adds canvas base font size to the env
/// - Sets the chosen font
/// - Measures character size for chosen font style and size, and sets Env `unitSize`
/// - Reads viewport size and sets `viewportRect` in the Env
/// - Sets `gridDimensions` in the Env, accounting for cell numbers if present
struct GridGeometryModifier: ViewModifier {
  @Environment(\.isShowingCellNumbers) private var isShowingCellNumbers: Bool

  let font: GridFont
  let fontSize: CGFloat
  let dimensions: GridDimensions

  func body(content: Content) -> some View {
    content
      /// The canvas/grid source-of-truth font size, used for deriving
      /// size transforms into other domains (e.g. ASCII UI mode).
      .environment(\.canvasBaseFontSize, fontSize)

      /// This provides the environment with `unitSize`
      .setCharacterSize(mode: .debounce(0.2))

      /// This provides the environment with `viewportRect`
      .viewportCapture(mode: .debounce(0.2), showsIndicator: false)

      .gridFont(font, size: fontSize)

      .environment(\.gridDimensions, effectiveDimensions)
  }
}

extension GridGeometryModifier {

  /// If cell numbers are showing, the grid needs to be enlarged by 1x cell to accomodate
  private var effectiveDimensions: GridDimensions {
    let additional: Int = isShowingCellNumbers ? 1 : 0
    let result = dimensions + additional
//    print("Checking out for Grid Dimensions: \(result)")
    return result
  }
}

extension View {
  /// A grid setup overload to accept a whole `GridCanvas`, to make it tidier
  public func gridSetup(
    font: GridFont,
    fontSize: CGFloat,
    dimensions: GridDimensions,
  ) -> some View {
    self.modifier(
      GridGeometryModifier(
        font: font,
        fontSize: fontSize,
        dimensions: dimensions
      )
    )
  }
}
