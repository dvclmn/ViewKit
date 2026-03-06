//
//  BoundaryShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import BasePrimitives

public enum BoundaryShape: String, Hashable, CaseIterable, Identifiable, Pickable, Sendable, Codable {
  
  public static let active: [Self] = [.circle, .square]
  
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
  public var icon: String {
    switch self {
      case .square: "square"
      case .circle: "circle"
      case .matchViewport: "macwindow"
    }
  }
}

extension BoundaryShape {
  
}

extension ActionLine.BoundaryKind {
  public func shape(from config: ActionLine.Configuration) -> ActionLine.BoundaryStyle {
    switch self {
      case .inner: config.innerShape
      case .outer: config.outerShape
    }
  }
}
