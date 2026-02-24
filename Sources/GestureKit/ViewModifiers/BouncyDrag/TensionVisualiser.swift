//
//  TensionVisualiser.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import SwiftUI
import LayoutKit

struct TensionCurveView: View {
  var radius: CGFloat
  var tension: CGFloat
  var samples: Int
  
  func output(for input: CGFloat) -> CGFloat {
    return input.scaledDistance(
      radius: radius,
      tension: tension,
    )
  }
  
  var lineWidth: CGFloat = 2
  
  var body: some View {
    GeometryReader { geo in
      let width = geo.size.width
      let height = geo.size.height
      
      Path { path in
        path.move(to: CGPoint(x: 0, y: height))
        for i in 0..<samples {
          let progress = CGFloat(i) / CGFloat(samples - 1)
          let input = progress * radius * 2
          let outputVal = output(for: input)
          let x = progress * width
          let y = height - (outputVal / radius) * height
          path.addLine(to: CGPoint(x: x, y: y))
        }
      }
      .stroke(Color.red, lineWidth: lineWidth)
      
      Path { path in
        path.move(to: geo.size.point(for: .bottomLeading))
        path.addLine(to: geo.size.point(for: .topTrailing))
      }
      .stroke(
        Color.blue.opacityMid,
        style: .init(
          lineWidth: lineWidth,
          lineCap: .round,
          dash: [lineWidth * 0.6, lineWidth * 2],
        )
      )
    }
    //    .padding()
    .frame(height: radius)
    .padding()
    
//    .debugTextOverlay(
//      "Radius: \(radius)",
//      "Tension: \(tension)",
//      alignment: .bottomTrailing
//    )
    .background(Color.gray.opacity(0.1))
    .clipShape(RoundedRectangle(cornerRadius: 8))
    .allowsHitTesting(false)
    
  }
}
