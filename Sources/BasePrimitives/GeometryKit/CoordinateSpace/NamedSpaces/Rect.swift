//
//  Rect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/3/2026.
//

import Foundation

public struct Rect<Space>: Sendable {
  public var x: CGFloat
  public var y: CGFloat
  public var width: CGFloat
  public var height: CGFloat
  
  public init(
    x: CGFloat,
    y: CGFloat,
    width: CGFloat,
    height: CGFloat
  ) {
    self.x = x
    self.y = y
    self.width = width
    self.height = height
  }
  
  public init(
    origin: CGPoint,
    size: CGSize
  ) {
    self.x = origin.x
    self.y = origin.y
    self.width = size.width
    self.height = size.height
  }
}
