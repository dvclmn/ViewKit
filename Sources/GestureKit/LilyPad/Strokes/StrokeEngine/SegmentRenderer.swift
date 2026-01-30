//
//  PointInterpolator.swift
//  Paperbark
//
//  Created by Dave Coleman on 30/5/2025.
//

//import ToolKit
//import GestureKit
//import SwiftUI

//public struct SegmentRenderer {
//  let segment: CatmullRomSegment
////  let touchPoints: [MappedTouchPoint]  // must be 4 points: p0–p3
//  let config: StrokeConfiguration
//  let curveType: CatmullRomType
//
//  public func interpolatePoint(
//    index: Int,
//    variableWidthPath: inout VariableWidthPath,
//    previousPoint: inout CGPoint?,
//  ) {
//    
//    
//    
//    if let previousPoint {
//
//      let direction = CGPoint(
//        x: interpolatedPosition.x - previousPoint.x,
//        y: interpolatedPosition.y - previousPoint.y
//      )
//      let normal = CGPoint(x: -direction.y, y: direction.x).normalised
//      let offset = normal * (width / 2)
//
//      /// This is simpler than I was letting myself realise. The `+/-` offset
//      /// is just sending the left/right edges out away from the 'spine', to form
//      /// the actual width amount (otherwise there would be no thickness)
//      variableWidthPath.leftEdge.append(interpolatedPosition + offset)
//      variableWidthPath.rightEdge.append(interpolatedPosition - offset)
//    }
//
//    previousPoint = interpolatedPosition
//  }
//}
