//
//  Model+DebugConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import SwiftUI
import BasePrimitives
import ColourKit

public struct PathDebugConfig {

  public let lineStyle: LineStyle<CGFloat>
  public let fillColour: RGBColour
  public let labelFontSize: CGFloat

  public init(
    lineStyle: LineStyle<CGFloat> = .init(),
    fillColour: RGBColour = .orange,
    labelFontSize: CGFloat = 11,
  ) {
    self.lineStyle = lineStyle
    self.fillColour = fillColour
    self.labelFontSize = labelFontSize
  }
}

//public struct LineStyle {
//  public let fillColour: Color
//  public let strokeColour: Color
//  public let linewidth: CGFloat
//
//  public init(
//    fillColour: Color = .indigo.opacityLow,
//    strokeColour: Color = .cyan,
//    linewidth: CGFloat = 1
//  ) {
//    self.fillColour = fillColour
//    self.strokeColour = strokeColour
//    self.linewidth = linewidth
//  }
//}
