//
//  ActionLines.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import SwiftUI

public struct ActionLineStyle {
  public var color: Color
  public var width: Double
  public var blendMode: BlendMode
  public var opacity: Double
  
  public init(
    color: Color,
    width: Double,
    blendMode: BlendMode = .normal,
    opacity: Double = 1
  ) {
    self.color = color
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

