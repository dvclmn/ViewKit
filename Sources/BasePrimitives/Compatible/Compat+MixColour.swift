//
//  Compat+MixColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/9/2025.
//

import SwiftUI

extension Color {
  //extension ShapeStyle where Self == Color {
  public func mixCompatible(
    with rhs: Self,
    by fraction: Double,
    in colorSpace: Gradient.ColorSpace = .perceptual
  ) -> Self {
    guard #available(macOS 15, iOS 18, *) else {
      return self
    }
    return self.mix(
      with: rhs,
      by: fraction,
      in: colorSpace
    )
  }
}

extension Array where Element == Color {
  /// Mix an array of colours into a single colour by repeatedly blending.
  public func mixMultiple(
    by fraction: Double = 0.5,
    fallback: Color = .clear
  ) -> Color {
    guard let first = self.first else { return fallback }
    return self.dropFirst().reduce(first) { accumulated, next in
      accumulated.mixCompatible(with: next, by: fraction)
    }
  }
}
