//
//  GridSetupModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import BasePrimitives
import SwiftUI


/// Aims to produce a full setup with Grid Font,
/// Character measure for unit size, injecting
/// into environment, etc.

struct GridGeometryModifier: ViewModifier {
  
  let font: GridFont
  let fontSize: CGFloat
  let dimensions: GridDimensions
  
  func body(content: Content) -> some View {
    content
    
    /// This provides the environment with `unitSize`
      .setCharacterSize(mode: .debounce(0.2))
    
    /// This provides the environment with `viewportRect`
      .viewportCapture(mode: .debounce(0.2), showsIndicator: false)
    
      .gridFont(font, size: fontSize)
    
      .environment(\.gridDimensions, dimensions)
  }
}

extension View {
  /// A grid setup overload to accept a whole `GridCanvas`,
  /// to make it a little tidier
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
