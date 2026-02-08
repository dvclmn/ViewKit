//
//  CGPoint+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/1/2026.
//

import SwiftUI

extension CGPoint {
  public init(floatX: Float, floatY: Float) {
    self.init(x: Double(floatX), y: Double(floatY))
  }
  
  public init(fromSize size: CGSize) {
    self.init(x: size.width, y: size.height)
  }

  public init(fromLength length: CGFloat) {
    self.init(x: length, y: length)
  }

  public var toCGSize: CGSize {
    return CGSize(width: self.x, height: self.y)
  }
}

extension CGPoint {
  
  public var invertedY: CGPoint {
    CGPoint(x: x, y: -y)
  }
  
  public var invertedX: CGPoint {
    CGPoint(x: -x, y: y)
  }
  
  public static func angleInRadians(
    from p1: CGPoint,
    to p2: CGPoint
  ) -> CGFloat {
    atan2(p2.y - p1.y, p2.x - p1.x)
  }

  public static func angle(from p1: CGPoint, to p2: CGPoint) -> Angle {
    Angle(radians: angleInRadians(from: p1, to: p2))
  }
}
