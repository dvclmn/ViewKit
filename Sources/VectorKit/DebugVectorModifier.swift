//
//  DebugCircleView.swift
//  DrawString
//
//  Created by Dave Coleman on 10/12/2024.
//

import CoreTools
import SwiftUI

#warning("Not sure if useful, need to inspect, then keep or remove")
public struct DebugVectorModifier: ViewModifier {

  let colour: Color
  let startPoint: CGPoint?
  let endPoint: CGPoint?

  public init(colour: Color, startPoint: CGPoint?, endPoint: CGPoint?) {
    self.colour = colour
    self.startPoint = startPoint
    self.endPoint = endPoint
  }

  public func body(content: Content) -> some View {
    GeometryReader { proxy in
      ZStack {
        content

        if let start = startPoint, let end = endPoint {
          Canvas { context, size in
            // Draw the vector line
            var path = Path()
            path.move(to: start)
            path.addLine(to: end)
            context.stroke(path, with: .color(colour), lineWidth: 2)

            // Draw start point
            let startCircle = Path(ellipseIn: CGRect(x: start.x - 5, y: start.y - 5, width: 10, height: 10))
            context.fill(startCircle, with: .color(colour))

            // Draw end point
            let endCircle = Path(ellipseIn: CGRect(x: end.x - 5, y: end.y - 5, width: 10, height: 10))
            context.fill(endCircle, with: .color(colour))
          }
          .allowsHitTesting(false)  // Ensure it doesn't intercept touch events

          // Calculate and display magnitude and angle
          if let magnitude = startPoint?.distance(to: endPoint ?? .zero),
            let angle = angleBetween(from: startPoint, to: endPoint)
          {
            VStack(alignment: .leading, spacing: 2) {
              Text(String(format: "Magnitude: %.2f", magnitude))
              Text(String(format: "Angle: %.2f°", angle))
            }
            .font(.caption)
            .foregroundColor(colour)
            .background(Color.black.opacity(0.6))
            .cornerRadius(4)
            .padding(5)
            .position(positionForLabel(from: startPoint, to: endPoint))
          }
        }
      }
    }
  }

  /// Helper to calculate angle in degrees
  private func angleBetween(from: CGPoint?, to: CGPoint?) -> CGFloat? {
    guard let from = from, let to = to else { return nil }
    let dx = to.x - from.x
    let dy = to.y - from.y
    let radians = atan2(dy, dx)
    return radians * 180 / .pi
  }

  /// Helper to position the label at the midpoint
  private func positionForLabel(from: CGPoint?, to: CGPoint?) -> CGPoint {
    guard let from = from, let to = to else {
      return CGPoint(x: 0, y: 0)
    }
    return CGPoint(x: (from.x + to.x) / 2, y: (from.y + to.y) / 2 - 20)
  }
}

extension View {
  public func debugPoints(
    colour: Color,
    startPoint: CGPoint?,
    endPoint: CGPoint?
  ) -> some View {
    self.modifier(DebugVectorModifier(colour: colour, startPoint: startPoint, endPoint: endPoint))
  }
}
