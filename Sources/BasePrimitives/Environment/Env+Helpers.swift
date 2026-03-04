//
//  Env+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension View {
  public func backgroundTint(_ style: AnyShapeStyle?) -> some View {
    self.environment(\.shapeStyleOverride, style)
  }

  public func backgroundTint(_ colour: Color?) -> some View {
    self.environment(\.colourOverride, colour)
  }

  public func isDebugMode(_ mode: Bool) -> some View {
    self.environment(\.isDebugMode, mode)
  }

  /// Font weight
  /// Symbol rendering mode (e.g. hierarchy) / variant (e.g. fill)
  /// Foreground style
  public func iconWeight(_ weight: Font.Weight) -> some View {
    self.environment(\.iconWeight, weight)
  }

  public func iconColour<S>(_ colour: S) -> some View where S: ShapeStyle {
    self.environment(\.iconColour, AnyShapeStyle(colour))
  }

  public func labelWeight(_ weight: Font.Weight) -> some View {
    self.environment(\.labelWeight, weight)
  }

  public func labelColour<S>(_ colour: S) -> some View where S: ShapeStyle {
    self.environment(\.labelColour, AnyShapeStyle(colour))
  }

  public func labelFontSize(_ size: CGFloat) -> some View {
    self.environment(\.labelFontSize, size)
  }

  public func labelFontStyle(_ style: Font.TextStyle) -> some View {
    self.environment(\.labelFontStyle, style)
  }

  public func labelTextCase(_ textCase: Text.Case) -> some View {
    self.environment(\.labelTextCase, textCase)
  }

  public func helpText(_ text: String) -> some View {
    self.environment(\.helpText, text).help(text)
  }
}
