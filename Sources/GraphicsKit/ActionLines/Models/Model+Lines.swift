//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import SwiftUI
import ColourKit

public struct ActionLineStyle {
  public var colour: HSVColour
//  public var color: Color
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

public enum BoundaryShape: Hashable, CaseIterable {
  case square
  case circle

  public var name: String {
    switch self {
      case .square: "Square"
      case .circle: "Circle"
    }
  }
}

