//
//  Model+GradientPoints.swift
//  BaseComponents
//
//  Created by Dave Coleman on 22/5/2025.
//


import SwiftUI


/// The words `start` and `end` are used here specifically
/// to make sense for both horizontal and vertical scrolling.
/// Horizontal: start = leading, end = trailing
/// Vertical: start = top, end = bottom
//public struct GradientPoints {
//  public let start: UnitPoint
//  public let end: UnitPoint
////  public let scrollLocation: ScrollLocation
//
//  static func startGradient(
//    axis: Axis,
////    scrollLocation: ScrollLocation,
//    convention: DimensionToAxisConvention
//  ) -> GradientPoints {
//    let orientation = GradientOrientation(axis: axis, convention: convention)
//    let points = orientation.points
//    return GradientPoints(start: points.start, end: points.end)
//  }
//  
//  static func endGradient(
//    axis: Axis,
////    scrollLocation: ScrollLocation,
//    convention: DimensionToAxisConvention
//  ) -> GradientPoints {
//    let orientation = GradientOrientation(axis: axis, convention: convention)
//    let points = orientation.points
//    return GradientPoints(start: points.start, end: points.end)
//  }
  
//  static func startGradient(
//    axis: Axis,
//    scrollLocation: ScrollLocation,
//    convention: DimensionToAxisConvention
//  ) -> GradientPoints {
//    switch (axis, convention) {
//      case (.horizontal, .widthIsHorizontal), (.vertical, .heightIsHorizontal):
//        return GradientPoints(
//          start: .leading,
//          end: .trailing,
//          scrollLocation: scrollLocation
//        )
//
//      case (.horizontal, .heightIsHorizontal), (.vertical, .widthIsHorizontal):
//        return GradientPoints(
//          start: .top,
//          end: .bottom,
//          scrollLocation: scrollLocation
//        )
//    }
//  }

//  static func endGradient(
//    axis: Axis,
//    scrollLocation: ScrollLocation,
//    convention: DimensionToAxisConvention
//  ) -> GradientPoints {
//    switch (axis, convention) {
//      case (.horizontal, .widthIsHorizontal), (.vertical, .heightIsHorizontal):
//        return GradientPoints(
//          start: .leading,
//          end: .trailing,
//          scrollLocation: scrollLocation
//        )
//
//      case (.horizontal, .heightIsHorizontal), (.vertical, .widthIsHorizontal):
//        return GradientPoints(
//          start: .top,
//          end: .bottom,
//          scrollLocation: scrollLocation
//        )
//    }
//  }
//}
