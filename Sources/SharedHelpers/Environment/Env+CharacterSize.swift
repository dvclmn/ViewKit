//
//  Env+CharacterSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI
import BasePrimitives

extension EnvironmentValues {
  
  /// This is directly related to `gridFont` and `canvasBaseFontSize`
  @Entry public var unitSize: CGSize?

  @Entry public var isASCIIMode: Bool = false
  @Entry public var canvasBaseFontSize: CGFloat?
  @Entry public var asciiModeFontSize: CGFloat?
  
  /// Scale ratio from canvas font size domain to ASCII mode font size domain.
  /// Example: canvas 28pt and ASCII 14pt gives a scale of 0.5.
  public var asciiScaleRelativeToCanvas: CGFloat? {
    guard
      let asciiModeFontSize,
      let canvasBaseFontSize,
      asciiModeFontSize.isFinite,
      canvasBaseFontSize.isFinite,
      asciiModeFontSize > 0,
      canvasBaseFontSize > 0
    else { return nil }
    
    return asciiModeFontSize / canvasBaseFontSize
  }
  
  /// Derived cell size for ASCII UI mode.
  ///
  /// This relies on `CharacterSizeModifier` providing `unitSize` with a value
  /// in an ancestor view, where `unitSize` is measured at `canvasBaseFontSize`.
  public var asciiUnitSize: CGSize? {
    guard let unitSize, let scale = asciiScaleRelativeToCanvas else { return nil }
    return unitSize * scale
  }
  
  /// Current effective unit size for the active domain.
  public var activeUnitSize: CGSize? {
    if isASCIIMode {
      return asciiUnitSize ?? unitSize
    }
    return unitSize
  }
  
}
