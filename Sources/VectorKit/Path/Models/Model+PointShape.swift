//
//  Model+PointShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import CoreTools
import SwiftUI

public enum PointShape: String, Pickable, Sendable, Hashable, Identifiable, CaseIterable, Codable {
  case square
  case circle
  case cross
  case triangle

  public var id: String { rawValue }

  public func updatePath(
    in rect: CGRect,
    path: inout Path
  ) {
    //  public func shapePath(in rect: CGRect) -> Path {
    //    var path = Path()
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2

    switch self {
      case .square:
        path.addRect(rect)

      case .circle:
        path.addEllipse(in: rect)

      case .cross:
        path.move(to: CGPoint(x: center.x - radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
        path.move(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x, y: center.y + radius))

      case .triangle:
        path.move(to: CGPoint(x: center.x - radius * 0.707, y: center.y + radius * 0.707))
        path.addLine(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x + radius * 0.707, y: center.y + radius * 0.707))
    }
  }
}
