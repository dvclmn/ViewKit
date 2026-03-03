//
//  Env+CharacterSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import BasePrimitives
import SwiftUI

extension EnvironmentValues {

  /// This is directly related to `gridFont` and `gridFontSize`
  @Entry public var unitSize: CGSize?

  @Entry public var isASCIIMode: Bool = false
  
  /// The font size used for `GridCanvasView`, e.g. for ASCII art display
  @Entry public var gridFontSize: CGFloat?
  @Entry public var asciiModeFontSize: CGFloat?

  /// Scale ratio from canvas font size domain to ASCII mode font size domain.
  /// Example: canvas 28pt and ASCII 14pt gives a scale of 0.5.
  public var asciiScaleRelativeToCanvas: CGFloat? {
    guard
      let asciiModeFontSize,
      let gridFontSize,
      asciiModeFontSize.isFinite,
      gridFontSize.isFinite,
      asciiModeFontSize > 0,
      gridFontSize > 0
    else { return nil }

    return asciiModeFontSize / gridFontSize
  }

  /// Derived cell size for ASCII UI mode.
  ///
  /// This relies on `CharacterSizeModifier` providing `unitSize` with a value
  /// in an ancestor view, where `unitSize` is measured at `gridFontSize`.
  public var asciiUnitSize: CGSize? {
    guard let unitSize, let scale = asciiScaleRelativeToCanvas else { return nil }
    return unitSize * scale
  }

  /// Current effective unit size, based on the ``isASCIIMode`` setting
  public var activeUnitSize: CGSize? {
    if isASCIIMode {
      return asciiUnitSize ?? unitSize
    }
    return unitSize
  }
}

public enum UnitSizeDomain {
  case canvas  // Returns `unitSize`
  case asciiMode  // Returns `asciiUnitSize`
  case automatic  // Defers to Environment's `activeUnitSize` value
  //case custom(CGSize)

  public var environmentKey: KeyPath<EnvironmentValues, CGSize?> {
    switch self {
      case .canvas: \.unitSize
      case .asciiMode: \.asciiUnitSize
      case .automatic: \.activeUnitSize
    //      case .custom(let size): nil
    }
  }
}
