//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import ColourKit
import SwiftUI
import CoreTools

extension ActionLine {
  public struct Style: Equatable {
    public var colour: HSVColour
    
    public var width: Double
    public var blendMode: BlendMode
    public var opacity: Double
    
    public var shape: LineShape
    
    public init(
      colour: HSVColour,
      shape: LineShape,
      width: Double,
      blendMode: BlendMode = .normal,
      opacity: Double = 1
    ) {
      self.colour = colour
      self.shape = shape
      self.width = width
      self.blendMode = blendMode
      self.opacity = opacity
    }
  }
  
}

@CaseDetection
public enum LineShape: String, CaseIterable, Identifiable {
  case triangle
  case diamond
  case wave // Add values here later
  
  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }
}
