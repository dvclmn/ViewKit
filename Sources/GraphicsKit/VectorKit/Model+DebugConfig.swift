//
//  Model+DebugConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import SwiftUI
import CoreTools
import ViewTools
import ColourTools
import BaseTools

public struct PathDebugConfig {
  
  public let lineStyle: LineStyle
  public let fillColour: RGBColour
  public let labelFontSize: CGFloat

  public init(
    lineStyle: LineStyle = .init(),
    fillColour: RGBColour = .orange,
    labelFontSize: CGFloat = 11,
  ) {
    self.lineStyle = lineStyle
    self.fillColour = fillColour
    self.labelFontSize = labelFontSize
  }
}

extension PathDebugConfig {
  public struct LineStyle {
    public let fillColour: RGBColour
    public let strokeColour: RGBColour
    public let lineWidth: CGFloat
    
    public init(
      fillColour: RGBColour = .aliceblue,
      strokeColour: RGBColour = .cyan,
      lineWidth: CGFloat = 1
    ) {
      self.fillColour = fillColour
      self.strokeColour = strokeColour
      self.lineWidth = lineWidth
    }
  }
}
