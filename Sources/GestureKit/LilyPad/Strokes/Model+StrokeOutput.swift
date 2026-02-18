//
//  Model+StrokeRenderOutput.swift
//  Paperbark
//
//  Created by Dave Coleman on 9/6/2025.
//

import SwiftUI

public enum StrokePhase: String, Codable, Sendable {
  case active
  case completed
}

//extension StrokeRenderOutput {
//
//  public func getHoveredStrokeID(
//    at hoveredPoint: CGPoint?,
//    threshold: CGFloat
//  ) -> TouchStroke.ID? {
//    guard let hoveredPoint else { return nil }
//    //    func findHoveredStroke(_ strokeOutput: StrokeRenderOutput) -> TouchStroke.ID? {
//    //      guard let hovered = store.mappedHoveredPoint else { return nil }
//    let hasMatchingPoint: Bool = self.points.contains { point in
//      point.distance(to: hoveredPoint) < threshold
//    }
//    return hasMatchingPoint ? self.id : nil
//    //      return strokeHasMatchingPoint ? self.id : nil
//    //    }
//  }
//
////  public func isStrokeHovered(
////    at hoveredPoint: CGPoint?,
////    threshold: CGFloat
////  ) -> Bool {
////    guard let hoveredPoint else { return false }
////    //    func findHoveredStroke(_ strokeOutput: StrokeRenderOutput) -> TouchStroke.ID? {
////    //      guard let hovered = store.mappedHoveredPoint else { return nil }
////    let hasMatchingPoint: Bool = self.points.contains { point in
////      point.distance(to: hoveredPoint) < threshold
////    }
////    return hasMatchingPoint
////    //      return strokeHasMatchingPoint ? self.id : nil
////    //    }
////  }
//}

//extension StrokeRenderOutput: CustomStringConvertible {
//  public var description: String {
//    "StrokeRenderOutput(ID: \(id), Path: \(path.description), Points: \(points.count)"
//  }
//}
