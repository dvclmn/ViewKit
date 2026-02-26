//
//  GeometryContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/2/2026.
//

import Foundation

/// This aims to express concepts similar to GridGeometry, CanvasGeometry, ArtworkGeometry
/// It's meant to help with situating one known rect within another known rect,
/// coordinate space conversions, etc
public protocol GeometryContext {
  associatedtype Size: DomainSize

  var viewportRect: CGRect { get }
  var itemSize: Size { get }
  
  var unitSize: UnitSize { get }
}

public protocol DomainSize {
  associatedtype Value

  var width: Value { get }
  var height: Value { get }

}

extension CGSize: DomainSize {
  public typealias Value = CGFloat
  //  public var widthValue: CGFloat { self.width }
  //  public var heightValue: CGFloat { self.height }
}

extension GridDimensions: DomainSize {
  public typealias Value = Int
}
