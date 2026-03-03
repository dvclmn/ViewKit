//
//  Size.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/3/2026.
//

import Foundation

public struct Size<Space>: Sendable, Equatable {
  public var width: CGFloat
  public var height: CGFloat

  public init(width: CGFloat, height: CGFloat) {
    self.width = width
    self.height = height
  }
}

extension Size {
  public init(fromCGSize size: CGSize) {
    self.init(width: size.width, height: size.height)
  }

  public var cgSize: CGSize {
    .init(width: width, height: height)
  }
  public static var zero: Self {
    .init(width: 0, height: 0)
  }
}
