//
//  TouchesHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools
import SwiftUI

//public typealias Strokes = [Stroke: StrokeConfig]
////public typealias Strokes = [StrokeConfig: Stroke]
////public typealias Points = [PointStyle: CGPoint]
//
////@Observable
//public struct DrawingData: Codable, Sendable {
//  /// This should always use the app's active stroke style settings
//  public var active: Stroke?
//  public var phase: InteractionPhase = .none
//
//  public var strokes: Strokes = [:]
//  //  public var strokes: [Stroke] = []
//  
//  enum CodingKeys: CodingKey {
////    case active
////    case phase
//    case strokes
//  }
//
//  public init() {}
//}
//
//extension DrawingData {
//  public var pointCount: Int {
//    strokes.reduce(into: 0) { partialResult, dict in
//      partialResult += dict.key.points.count
//    }
//  }
//  public var strokeCount: Int { strokes.count }
//}
