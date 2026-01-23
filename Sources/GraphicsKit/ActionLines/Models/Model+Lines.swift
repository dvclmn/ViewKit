//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import ColourKit
import SwiftUI

extension ActionLine {
  public struct Style {
    public var colour: HSVColour
    
    public var width: Double
    public var blendMode: BlendMode
    public var opacity: Double
    
    public init(
      colour: HSVColour,
      width: Double,
      blendMode: BlendMode = .normal,
      opacity: Double = 1
    ) {
      self.colour = colour
      self.width = width
      self.blendMode = blendMode
      self.opacity = opacity
    }
  }
  
}
