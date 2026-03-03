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

  public var activeGridFontSize: CGFloat? {
    if isASCIIMode {
      return asciiModeFontSize ?? gridFontSize
    }
    return gridFontSize
  }
}

/// There are two discrete areas that need a GridFont / unitSize
/// to be declared; `GridCanvasView` and the
/// `EnvironmentValues/isASCIIMode`
public enum GridFontDomain: Sendable {
  case canvas  // Returns `unitSize`
  case asciiMode  // Returns `asciiUnitSize`
  case automatic  // Defers to Environment's `activeUnitSize` value

  public var unitSizeKey: KeyPath<EnvironmentValues, CGSize?> {
    switch self {
      case .canvas: \.unitSize
      case .asciiMode: \.asciiUnitSize
      case .automatic: \.activeUnitSize
    }
  }

  public var fontSizeKey: KeyPath<EnvironmentValues, CGFloat?> {
    switch self {
      case .canvas: \.gridFontSize
      case .asciiMode: \.asciiModeFontSize
      case .automatic: \.activeGridFontSize
    }
  }

  public func gridFont(in env: EnvironmentValues) -> GridFont? {
    env.gridFont
  }

  public func gridFontSize(in env: EnvironmentValues) -> CGFloat? {
    env[keyPath: fontSizeKey]
  }

  public func unitSize(in env: EnvironmentValues) -> CGSize? {
    env[keyPath: unitSizeKey]
  }
}

public enum GridFontConfig: Sendable {
  case domain(GridFontDomain)
  case custom(GridFont, size: CGFloat)

  /// `passthrough` allows `CharacterSizeModifier` to measure whatever
  /// font is currently set in that View hierarchy
  case passthrough

  public static let automatic: Self = .domain(.automatic)

  public func descriptor(in environment: EnvironmentValues) -> GridFontDescriptor? {
    switch self {
      case .domain(let domain):
        guard let style = domain.gridFont(in: environment),
          let size = domain.gridFontSize(in: environment)
        else { return nil }
        return GridFontDescriptor(style: style, size: size)

      case .custom(let font, let size):
        return GridFontDescriptor(style: font, size: size)

      case .passthrough: return nil
    }
  }
}

public struct GridFontDescriptor {
  let style: GridFont
  let size: CGFloat

  public init(
    style: GridFont,
    size: CGFloat
  ) {
    self.style = style
    self.size = size
  }
}

extension GridFontDescriptor {
  public var font: Font {
    //    guard let size, let gridFont else { return nil }
    return switch style {
      case .sfMono:
        .system(
          size: size,
          design: .monospaced
        )
      default:
        .custom(style.rawValue, fixedSize: size)
    }

  }
}
