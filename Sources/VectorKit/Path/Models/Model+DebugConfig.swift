//
//  Model+DebugConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import SwiftUI
import BasePrimitives

public struct PathDebugConfig {

  public let pathStyle: LineStyle
  public let labelFontSize: CGFloat

  public init(
    pathStyle: LineStyle = .init(),
    labelFontSize: CGFloat = 11,
  ) {
    self.pathStyle = pathStyle
    self.labelFontSize = labelFontSize
  }
}

public struct LineStyle {
  public let fillColour: Color
  public let strokeColour: Color
  public let linewidth: CGFloat

  public init(
    fillColour: Color = .indigo.opacityLow,
    strokeColour: Color = .cyan,
    linewidth: CGFloat = 1
  ) {
    self.fillColour = fillColour
    self.strokeColour = strokeColour
    self.linewidth = linewidth
  }
}
