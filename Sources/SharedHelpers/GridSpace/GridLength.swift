//
//  Floateger.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

import SwiftUI

public struct GridLength: Hashable, Codable {
  public var count: Int
  public var unit: CGFloat
  
  public init(count: Int, unit: CGFloat) {
    self.count = count
    self.unit = unit
  }

  public init(screenLength: CGFloat, unit: CGFloat) {
    self.count = Int((screenLength / unit).rounded(.towardZero))
    self.unit = unit
  }
}

extension GridLength {
  
  public var screenLength: CGFloat {
    CGFloat(count) * unit
  }
}

//public typealias Floateger = (count: Int, length: CGFloat)
//public typealias Sizeger = (count: Int, length: CGSize)
//
//public struct IntFloat {
//  let count: Int
//}
//
//public struct IntSize {
//  let width: Int
//  let height: Int
//  
//  public init(
//    width: Int,
//    height: Int
//  ) {
//    self.width = width
//    self.height = height
//  }
//}

//public enum Floateger {
//  case asInt(Int)
//  case asFloat(CGFloat)
//}
