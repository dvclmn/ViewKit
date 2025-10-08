//
//  Model+ScrollGeometry.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/10/2025.
//

import SwiftUI

public struct ScrollContext: Equatable, Sendable {
  /// Size of the entire content, which may be smaller
  /// or larger than the scroll view itself
  public var contentSize: CGSize
  
  /// This is the overall size of the scroll view. Combining this
  /// and the content offset will give you the current visible rect
  /// of the scroll view.
  public var containerSize: CGSize
  
  /// This is the position of the scroll view within its overall content size.
  public var contentOffset: CGPoint
  
  public var location: ScrollLocation
}

@available(macOS 15.0, iOS 18.0, *)
extension ScrollContext {
  public init(
    fromGeometry geometry: ScrollGeometry,
    withAxis axis: Axis,
    tolerance: CGFloat = 2.0
  ) {
    self.location = ScrollLocation(
      fromGeometry: geometry,
      withAxis: axis,
      tolerance: tolerance
    )
    self.contentSize = geometry.contentSize
    self.containerSize = geometry.containerSize
    self.contentOffset = geometry.contentOffset
  }
}
