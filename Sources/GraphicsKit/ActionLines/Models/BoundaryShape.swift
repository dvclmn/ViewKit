//
//  BoundaryShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import CoreTools

public enum BoundaryShape: String, Hashable, CaseIterable, Identifiable, Pickable {
  case square
  case circle
  case matchViewport

  public var name: String {
    switch self {
      case .square: "Square"
      case .circle: "Circle"
      case .matchViewport: "Viewport"
    }
  }
}
