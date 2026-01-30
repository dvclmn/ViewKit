//
//  Stroke+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/1/2026.
//

import Foundation
import ColourKit

extension DrawingData {
  static func makeStrokes(
    from strokes: [Stroke],
  ) -> Strokes {
    Dictionary(uniqueKeysWithValues: strokes.map { stroke in
      let config = StrokeConfig()
//      let style = PointStyle.basic(with: colour)
      return (stroke, config)
    })
  }
  
  public mutating func addStrokes(_ strokes: [Stroke]) {
    let new = Self.makeStrokes(from: strokes)
    self.strokes.merge(new) { _, new in
      new
    }
    //    self.points.merge(points) { current, new in
    //      new
    //    }
  }
}

extension Stroke {
  // If you pass a colour, we create a basic style for each point.
//  static func makePoints(from points: [CGPoint], colour: RGBColour) -> Points {
//    Dictionary(uniqueKeysWithValues: points.map { point in
//      let style = PointStyle.basic(with: colour)
//      return (point, style)
//    })
//  }
  
  
//  public mutating func addPoints(_ points: [CGPoint]) {
//    let new = Self.makePoints(from: points, colour: RGBColour.brown)
//    self.points.merge(new) { _, new in
//      new
//    }
//    //    self.points.merge(points) { current, new in
//    //      new
//    //    }
//  }

  
  // If you already have a style, apply that style to all points.
//  static func makePoints(from points: [CGPoint], style: PointStyle) -> Points {
//    Dictionary(uniqueKeysWithValues: points.map { point in
//      (style, point)
//    })
//  }
}
