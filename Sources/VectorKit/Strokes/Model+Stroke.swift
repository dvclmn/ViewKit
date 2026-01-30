//
//  Models.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

import ToolKit
import GestureKit
import ColourKit
import SwiftUI

//struct TouchStrokeActive: Identifiable, Codable, Equatable, Sendable, Hashable {
//  let id: UUID
//  var points: [TouchPoint]
////  var points: [MappedTouchPoint]
//  var timestamp: TimeInterval
//
//  public init(
//    id: UUID = UUID(),
//    points: [TouchPoint],
////    points: [MappedTouchPoint],
//  ) {
//    self.id = id
//    self.points = points
//    self.timestamp = points.first?.timestamp ?? Date.now.timeIntervalSinceReferenceDate
//  }
//}

/// `points` should be *all* points that come from AppKit.
/// This provides options for adding, removing, etc somewhere
/// else in the pipeline, more flexibility.
struct TouchStrokeCompleted: Identifiable, Codable, Equatable, Sendable, Hashable {
  let id: UUID
  let layerID: Layer.ID
  var points: [TouchPoint]
//  var points: [MappedTouchPoint]
  var pathString: String
  var colour: RGBColour
  var config: StrokeConfiguration
  var timestamp: TimeInterval
  var transform: CGAffineTransform

  public init(
    id: UUID = UUID(),
    layerID: Layer.ID,
    points: [TouchPoint],
//    points: [MappedTouchPoint],
    pathString: String,
    colour: RGBColour,
    config: StrokeConfiguration,
    transform: CGAffineTransform = .identity,
  ) {
    self.id = id
    self.layerID = layerID
    self.points = points
    self.pathString = pathString
    self.colour = colour
    self.config = config
    self.transform = transform

    self.timestamp = points.first?.timestamp ?? Date.now.timeIntervalSinceReferenceDate

  }
}


extension TouchStrokeCompleted {

  /// Note: This only returns an optional `StrokeRenderOutput` because
  /// reconstructing the `Path` from a string is not guaranteed to work.
  ///
  /// The rest of the output generation process (at this point)
  /// creates output that is guaranteed to be present.
  public func output(
    shouldRegeneratePathForDebug: Bool = false
  ) -> StrokeRenderOutput? {

    let path: Path
    if shouldRegeneratePathForDebug {
      path = StrokeEngine.generatePathFromStroke(
        points: self.points,
        config: self.config
      )
    } else {
      guard let pathFromString = try? getPathFromString() else { return nil }
      path = pathFromString
    }
    let newOutput = StrokeRenderOutput(
      id: self.id,
      layerID: self.layerID,
      timestamp: self.timestamp,
      path: path,
      colour: self.colour.toColour,
      points: self.points.cgPoints,
      transform: self.transform
    )
    return newOutput
  }
  //  public var output: StrokeRenderOutput? {
  //    guard let path = try? getPathFromString() else { return nil }
  //    let newOutput = StrokeRenderOutput(
  //      id: self.id,
  //      timestamp: self.timestamp,
  //      path: path,
  //      colour: self.colour.nativeColour,
  //      points: self.points.cgPoints
  //    )
  //    return newOutput
  //  }

  public func getPathFromString() throws -> Path {
    guard let path = Path(pathString) else {
      throw StrokeError.couldNotRecreatePathFromString
    }
    return path
  }
}

extension Array where Element == TouchStrokeCompleted {
  func allOutputs(shouldRegeneratePathsForDebug: Bool = false) -> [StrokeRenderOutput] {
    return self.compactMap { stroke in
      stroke.output(shouldRegeneratePathForDebug: shouldRegeneratePathsForDebug)
    }
  }
}
//extension Array where Element == Layer {
//  func allOutputs() -> [LayerRenderOutput] {
//    return self.map { layer in
//      layer.renderOutput()
//    }
//  }
//}
