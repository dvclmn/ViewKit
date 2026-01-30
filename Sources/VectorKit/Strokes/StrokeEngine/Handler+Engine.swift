//
//  Model+StrokeEngine.swift
//  LilyPad
//
//  Created by Dave Coleman on 5/5/2025.
//

import ToolKit
import GestureKit
import Sharing
import SwiftUI

struct StrokeEngine {

  static func generatePathFromStroke(
    points: [TouchPoint],
//    points: [MappedTouchPoint],
    config: StrokeConfiguration
  ) -> Path {

    guard let firstPoint = points.first else {
      print("No points from which to create a Path")
      return Path()
    }
    guard points.count > 1 else {
      /// Otherwise, we can artifically add something that will give a 'dot'
      let singleDotPoints: [CGPoint] = firstPoint.position.generateGoldenSpiral(turns: 2, scale: config.averageStrokeWidth, pointCount: 28)
      return singleDotPoints.toPath()
    }
    var variableWidthPath = VariableWidthPath()

    for point in points {
      processSinglePoint(
        point,
        config: config,
        variableWidthPath: &variableWidthPath
      )
    }
    return variableWidthPath.generatePath(usesSmoothCurves: false)
  }

  private static func processSinglePoint(
    _ point: TouchPoint,
//    _ point: MappedTouchPoint,
    config: StrokeConfiguration,
    variableWidthPath: inout VariableWidthPath
  ) {
    let width: CGFloat = StrokeWidthHandler.calculateStrokeWidth(
      speed: point.velocity.speed,
      pressure: point.pressure,
      config: config
    )

    variableWidthPath.addPoint(
      to: point.position,
      rawWidth: width
    )
  }
}
