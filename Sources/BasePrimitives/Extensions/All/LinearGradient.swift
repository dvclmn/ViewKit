//
//  LinearGradient.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import SwiftUI

//@MainActor
extension LinearGradient {
  public static func rainbow(
    start: UnitPoint = .leading,
    end: UnitPoint = .trailing
  ) -> LinearGradient {
    LinearGradient(
      colors: .rainbow,
      startPoint: start,
      endPoint: end
    )
  }

  public static func lightFalloff(
    _ colour: Color = .white.opacity(0.1),
    direction: Alignment = .top,
    falloffAmount: CGFloat = 0.9
  ) -> LinearGradient {

    LinearGradient(
      colors: [
        colour,
        colour.opacity(falloffAmount.inversePercentage),
      ],
      startPoint: direction.toUnitPoint(),
      endPoint: direction.toOpposing.toUnitPoint()
    )
  }
}

extension Array where Element == Color {
  public static let rainbow: [Color] = [
    .red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink, .red,
  ]

}
