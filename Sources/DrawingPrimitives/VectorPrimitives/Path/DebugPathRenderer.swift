//
//  DebugPathRenderer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import BasePrimitives
import SwiftUI

public struct PathDebugRenderer {
  let result: PathDebugResult
  let config: PathDebugConfig
  let zoomPercent: CGFloat?

  public func draw(in context: GraphicsContext) {
    context.stroke(
      result.original,
      with: .color(config.lineStyle.colour.toColour),
      lineWidth: config.lineStyle.lineWidth)

    /// Draw paths and points
    for (element, path) in result.debugPaths {
      context.fill(path, with: .color(element.displayColour))

      if element == .connection {
        context.stroke(
          result.connections,
          with: .color(element.displayColour),
          lineWidth: config.lineStyle.lineWidth
        )
      }
    }

    /// Draw coordinate labels
    for label in result.labelPoints where label.element.isLabelled {
      #warning("Need to bring thid back")
//      context.drawDebugText(
//        label.point.debugDescription,
//        //        label.point.displayString(places: 0, labelStyle: .none),
//        at: label.point,
//        positioned: .aboveOrigin,
//        colour: .primary,
//        fontSize: config.labelFontSize,
//        pointDisplay: .none,
//      )
    }
  }

  @ViewBuilder
  public func shapeView() -> some View {
    ZStack {
      /// Original path
      result.original
        .stroke(config.lineStyle.colour.toColour, lineWidth: config.lineStyle.lineWidth)

      /// Connection lines
      result.connections
        .stroke(DebugPathElement.connection.displayColour, lineWidth: config.lineStyle.lineWidth)

      /// Control points
      result.controlPoints
        .fill(DebugPathElement.controlBezier.displayColour)

      /// Node points
      result.nodes
        .fill(DebugPathElement.nodeLine.displayColour)
    }
  }
}

extension GraphicsContext {

  public func debugPath(
    path: Path,
    config: PathDebugConfig = .init(),
    zoomPercent: CGFloat?
  ) {
    let result = path.analyse()
    PathDebugRenderer(
      result: result,
      config: config,
      zoomPercent: zoomPercent
    ).draw(in: self)
  }

}
