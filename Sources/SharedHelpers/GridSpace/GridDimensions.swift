//
//  GridDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

public struct GridDimensions {
  public let width: Int
  public let height: Int
  
  public init(width: Int, height: Int) {
    self.width = width
    self.height = height
  }
  public init(_ width: Int, _ height: Int) {
    self.init(width: width, height: height)
  }
}
