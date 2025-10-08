//
//  Color.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

extension Array where Element == Color {
  
  /// Mix an array of colours into a single colour by repeatedly blending.
  public func mixMultiple(
    //    _ colours: [Color],
    by fraction: Double = 0.5,
    fallback: Color = .clear
  ) -> Color {
    guard let first = self.first else { return fallback }
    return self.dropFirst().reduce(first) { accumulated, next in
      accumulated.mixCompatible(with: next, by: fraction)
    }
  }
}
