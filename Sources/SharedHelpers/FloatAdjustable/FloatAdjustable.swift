//
//  FloatAdjustable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

public protocol FloatAdjustable {
  
}

extension FloatAdjustable {
  
  public func adjustLength(
    _ axis: Axis,
    newValue: CGFloat
  ) -> CGSize {
    switch axis {
      case .horizontal:
        return CGSize(width: newValue, height: self.height)
        
      case .vertical:
        return CGSize(width: self.width, height: newValue)
    }
  }
  
  /// I think this and the below (that transforms both axes)
  /// just allow the caller to hop in and  'do some stuff' to
  /// the values, before creating a new size from them.
  public func adjustLength(
    _ axis: Axis,
    transform: (CGFloat) -> CGFloat
  ) -> CGSize {
    let transformed = transform(axis.length(fromSize: self))
    return self.adjustLength(axis, newValue: transformed)
  }
  
  public func adjustLengths(
    transform: (CGFloat, CGFloat) -> (width: CGFloat, height: CGFloat)
  ) -> CGSize {
    let transformed = transform(self.width, self.height)
    return CGSize(width: transformed.width, height: transformed.height)
  }
  
  public func adjustLengths(by value: CGFloat) -> CGSize {
    return CGSize(self.width * value, self.height * value)
    //    let transformed = transform(self.width, self.height)
    //    return CGSize(width: transformed.width, height: transformed.height)
  }
}
