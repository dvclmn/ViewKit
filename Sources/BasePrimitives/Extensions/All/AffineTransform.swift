//
//  AffineTransform.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

extension AffineTransform {
  public mutating func translate(using point: CGPoint) {
    self.translate(x: point.x, y: point.y)
  }
}
