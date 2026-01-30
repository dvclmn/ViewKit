//
//  Model+StrokeRenderOutput.swift
//  Paperbark
//
//  Created by Dave Coleman on 9/6/2025.
//

import SwiftUI

//public enum StrokePhase: String, Codable, Sendable {
//  case active
//  case completed
//}
//
//public struct StrokeRenderOutput: Equatable {
//  let id: TouchStrokeCompleted.ID
//  let layerID: Layer.ID
//  let timestamp: TimeInterval
//  var path: Path
//  var colour: Color
//  var points: [CGPoint]
//  var transform: CGAffineTransform
//
//  init(
//    id: TouchStrokeCompleted.ID,
//    layerID: Layer.ID,
//    timestamp: TimeInterval,
//    path: Path,
//    colour: Color,
//    points: [CGPoint],
//    transform: CGAffineTransform
//  ) {
//    self.id = id
//    self.layerID = layerID
//    self.timestamp = timestamp
//    self.path = path
//    self.colour = colour
//    self.points = points
//    self.transform = transform
//  }

  //  init(_ stroke: TouchStrokeCompleted) {
  //    let path = StrokeEngine.generatePathFromStroke(
  //      points: stroke.points,
  //      config: stroke.config
  //    )
  ////    let path = try stroke.getPathFromString()
  //    self.init(
  //      id: stroke.id,
  //      timestamp: stroke.timestamp,
  //      path: path,
  //      colour: stroke.colour.toColour,
  //      points: stroke.points.cgPoints
  //    )
  //  }
  //  init(
  //    _ stroke: TouchStroke,
  //    path: Path
  //  ) {
  //    self.init(
  //      id: stroke.id,
  //      timestamp: stroke.timestamp,
  //      path: path,
  //      colour: stroke.colour.toColour,
  //      points: stroke.points.cgPoints
  //    )
  //  }
//}

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
