//
//  TouchStrokeExamples.swift
//  Paperbark
//
//  Created by Dave Coleman on 9/6/2025.
//

import SwiftUI

//public enum TouchStrokeExample {
//  case spiral
//  case figure8
//  case wave
//  case rotated
//  case basic
//  
//  private var normalisedPoints: [TouchPoint] {
//    switch self {
//      case .spiral: TouchPoint.spiralPoints
//      case .figure8: TouchPoint.figure8Points
//      case .wave: TouchPoint.wavePoints
//      case .basic: TouchPoint.exampleGroup
//      case .rotated: TouchPoint.exampleGroup
//    }
//  }
//  
//  var config: StrokeConfiguration {
//    switch self {
//      case .spiral: StrokeConfiguration.default
//      case .figure8: StrokeConfiguration.default
//      case .wave: StrokeConfiguration.default
//      case .rotated: StrokeConfiguration.default
//      case .basic: StrokeConfiguration.default
//    }
//  }
//  
//  public var stableIdentifier: UUID {
//    switch self {
//      case .spiral: UUID(1)
//      case .figure8: UUID(2)
//      case .wave: UUID(3)
//      case .rotated: UUID(4)
//      case .basic: UUID(5)
//    }
//  }
//  
//  public func path(in mappingSize: CGSize) -> Path {
//    let points = self.points(in: mappingSize)
//    return StrokeEngine.generatePathFromStroke(
//      points: points,
//      config: self.config
//    )
//  }
//  
//  public var transform: CGAffineTransform {
//    switch self {
//      case .spiral, .figure8, .wave, .basic: .identity
//      case .rotated: .rotate45
//    }
//  }
//  public func points(in mappingSize: CGSize) -> [MappedTouchPoint] {
//    let result = MappedTouchPointsBuilder(
//      touches: self.normalisedPoints.toSet(),
//      in: mappingSize
//    ).mappedTouches
//    return result.toArray
//  }
//}

//extension TouchStrokeCompleted {
  
//  public static func examples(
//    _ examples: [TouchStrokeExample] = [.spiral],
//    layerID: Layer.ID,
//    colour: RGBColour = .purple,
//    transform: CGAffineTransform = .identity,
//    in mappingSize: CGSize = .trackpad
//  ) -> IdentifiedArrayOf<TouchStrokeCompleted> {
//    
//    var strokes: IdentifiedArrayOf<TouchStrokeCompleted> = []
//    
//    for exampleStroke in examples {
//      
//      let points = exampleStroke.points(in: mappingSize)
//      let config = exampleStroke.config
//      let path = exampleStroke.path(in: mappingSize)
//      
//      let newStroke = TouchStrokeCompleted(
//        id: exampleStroke.stableIdentifier,
//        layerID: layerID,
//        points: points,
//        pathString: path.description,
//        colour: colour,
//        config: config,
//        transform: exampleStroke.transform,
////        pathString: nil
//      )
//      strokes.append(newStroke)
//    }
//    
//    return strokes
//  }
//}
