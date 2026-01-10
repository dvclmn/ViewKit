//
//  Model+ScrollLocation.swift
//  BaseComponents
//
//  Created by Dave Coleman on 22/5/2025.
//

import SwiftUI
import BasePrimitives

/// Chosen terms `start` and `end` to provide the flexibility to
/// be referring to both horizontal or vertical `ScrollView`s
public enum ScrollLocation: String, Sendable {
  case start
  case mid
  case end

  /// Content does not overflow it's frame, so no scrolling required
  /// Note: use `ScrollGeometry/contentOffset` as metric?
  /// Can also be thought of as expressing both `start` and `end` in one
  case contained

  @available(macOS 15.0, iOS 18.0, *)
  public init(
    fromGeometry geometry: ScrollGeometry,
    withAxis axis: Axis2D,
    mapping: AxisMapping = .default,
    tolerance: CGFloat = 2.0
  ) {

    let containerLength = geometry.containerSize.value(along: axis, mapping: mapping)
    let contentLength = geometry.contentSize.value(along: axis, mapping: mapping)
    let insetsLength = geometry.contentInsets.value(along: axis, mapping: mapping)
    let offsetLength = geometry.contentOffset.value(along: axis, mapping: mapping)
    
//    let containerLength = axis.length(fromSize: geometry.containerSize)
//    let contentLength = axis.length(fromSize: geometry.contentSize)
//    let insetsLength = axis.length(fromInsets: geometry.contentInsets)

    let isWithinBounds = contentLength <= containerLength

    /// Let's first rule out whether the content is already *contained* within the bounds.
    /// If so, we have our `ScrollLocation`, and we don't need to do anything else
    if isWithinBounds { self = .contained }

    /// I think it is working
    

    /// The total scrollable length = full content size - visible container size
    let maxOffset: CGFloat = contentLength - containerLength - insetsLength

    /// Determine position
    let isAtStart = offsetLength <= tolerance
    let isAtEnd = offsetLength >= (maxOffset - tolerance)

    if isAtStart {
      self = .start
    } else if isAtEnd {
      self = .end
    } else {
      self = .mid
    }
  }

  public var name: String {
    switch self {
      case .start: "Start"
      case .mid: "Mid-scroll"
      case .end: "End"
      case .contained: "Content contained within Bounds"
    }
  }
}
