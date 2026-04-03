//
//  Env+CharacterSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI
import InteractionKit

extension EnvironmentValues {

  /// This is directly related to `gridFont` and `gridCanvasFontSize`
  @Entry public var unitSize: CGSize?

  @Entry public var isASCIIMode: Bool = false

  /// The font size used for `GridCanvasView`, e.g. for ASCII art display
  @Entry public var gridCanvasFontSize: CGFloat?
  @Entry public var asciiModeFontSize: CGFloat?
}

extension EnvironmentValues {
  /// Scale ratio from canvas font size domain to ASCII mode font size domain.
  /// Example: canvas 28pt and ASCII 14pt gives a scale of 0.5.
  public var asciiScaleRelativeToCanvas: CGFloat? {
    guard
      let asciiModeFontSize,
      let gridCanvasFontSize,
      asciiModeFontSize.isFinite,
      gridCanvasFontSize.isFinite,
      asciiModeFontSize > 0,
      gridCanvasFontSize > 0
    else { return nil }

    return asciiModeFontSize / gridCanvasFontSize
  }

  /// Derived cell size for ASCII UI mode.
  ///
  /// This relies on `CharacterSizeModifier` providing `unitSize` with a value
  /// in an ancestor view, where `unitSize` is measured at `gridCanvasFontSize`.
  public var asciiUnitSize: CGSize? {
    guard let unitSize, let scale = asciiScaleRelativeToCanvas else { return nil }
    return unitSize * scale
  }

  /// Current effective unit size, based on the ``isASCIIMode`` setting
  public var activeUnitSize: CGSize? {
    if isASCIIMode {
      return asciiUnitSize
//      return asciiUnitSize ?? unitSize
    }
    return unitSize
  }

  public var activeGridFontSize: CGFloat? {
    if isASCIIMode {
      return asciiModeFontSize
//      return asciiModeFontSize ?? gridCanvasFontSize
    }
    return gridCanvasFontSize
  }
}
