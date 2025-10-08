//
//  LineGraphView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 27/8/2025.
//

//import BaseHelpers
import SwiftUI

public struct LineGraphView: View {
  @Environment(\.self) private var envSelf
  
  private let isSmoothPath: Bool = true

  let samples: [CGFloat]
  let barSpacing: CGFloat
  let barWidth: CGFloat
  let colour: Color
  let contrastColour: Color
//  let colour: CodableColour
  public var body: some View {

    Canvas {
      context,
      size in
      /// Compute bar centre positions
      var points: [CGPoint] = []
      for (index, height) in samples.enumerated() {
        let x = CGFloat(index) * (barWidth + barSpacing) + (barSpacing * 1.5)
        let y = size.height - height
        points.append(CGPoint(x: x, y: y))
      }

      let path: Path

      if isSmoothPath {
        /// Build smooth path
        path = Path.catmullRomPath(
          points: points,
          tension: 0.5,
          closed: false,
          samples: 12
        )
      } else {
        path = Path(fromPoints: points, shouldDropFirst: false)
      }

      context.stroke(
        path, with: .color(contrastColour), lineWidth: 2)
//        path, with: .color(colour.contrastColour(strength: .moderate, environment: envSelf).colour), lineWidth: 2)
    }
  }
}
