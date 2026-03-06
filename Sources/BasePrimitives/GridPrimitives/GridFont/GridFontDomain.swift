//
//  GridFontDomain.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

/// There are two discrete areas that need a GridFont / unitSize
/// to be declared; `GridCanvasView` and the
/// `EnvironmentValues/isASCIIMode`
public enum GridFontDomain: Sendable {
  case canvas  // Returns `unitSize`
  case asciiMode  // Returns `asciiUnitSize`
  case automatic  // Defers to Environment's `activeUnitSize` value
  
  var isASCIIMode: Bool { self == .asciiMode }
  
  public func unitSize(in env: EnvironmentValues) -> CGSize? {
    let key: KeyPath<EnvironmentValues, CGSize?> =
      switch self {
        case .canvas: \.unitSize
        case .asciiMode: \.asciiUnitSize
        case .automatic: \.activeUnitSize
      }
    return env[keyPath: key]
  }

  public func fontSize(in env: EnvironmentValues) -> CGFloat? {
    let key: KeyPath<EnvironmentValues, CGFloat?> =
      switch self {
        case .canvas: \.gridCanvasFontSize
        case .asciiMode: \.asciiModeFontSize
        case .automatic: \.activeGridFontSize
      }
    return env[keyPath: key]
  }
  
  /// Fallback used when no `gridFont` has been provided in the Environment.
//  public var fallbackFont: GridFont {
//    switch self {
//      case .asciiMode: .terminal
//      case .canvas, .automatic: .sfMono
//    }
//  }
  
  /// Fallback used when no domain-specific font size is available.
//  public var fallbackFontSize: CGFloat { 20 }

}
