//
//  CGSize+Conversion.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

extension CGSize {

  public var toCGRectZeroOrigin: CGRect { CGRect(origin: .zero, size: self) }
  
  public var toCGPoint: CGPoint { CGPoint(x: width, y: height) }

  public func point(for unitPoint: UnitPoint) -> CGPoint {
    unitPoint.toCGPoint(in: self)
  }

}
