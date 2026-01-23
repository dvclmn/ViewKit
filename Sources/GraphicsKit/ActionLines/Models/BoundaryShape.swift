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

extension ActionLine.BoundaryKind {
  public func shape(from config: ActionLine.Configuration) -> ActionLine.Shape {
    switch self {
      case .inner: return config.innerShape
      case .outer: return config.outerShape
    }
  }
  
//  public func variation(
//    at index: Int,
//    from variations: ActionLineVariations
//  ) -> Double {
//    switch self {
//      case .inner: return variations.boundaryInner[index]
//      case .outer: return variations.boundaryOuter[index]
//    }
//  }
}
