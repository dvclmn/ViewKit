//
//  LinearGradient.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import SwiftUI

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
}


extension Array where Element == Color {
  public static let rainbow: [Color] = [
    .red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink, .red,
  ]
}
