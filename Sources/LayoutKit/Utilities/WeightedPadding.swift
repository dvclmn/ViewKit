//
//  WeightedPadding.swift
//  BaseStyles
//
//  Created by Dave Coleman on 2/3/2025.
//

import SwiftUI

public struct WeightedPaddingModifier: ViewModifier {
  let padding: CGFloat
  let horizontalBias: CGFloat  // Increase to add width
  let opticalCentreBias: CGFloat  // Increase to shift content upward
  let excludedEdge: Edge?

  public func body(content: Content) -> some View {
    content
      .safeAreaPadding(.top, adjustedPadding.top)
      .safeAreaPadding(.bottom, adjustedPadding.bottom)
      .safeAreaPadding(.leading, adjustedPadding.leading)
      .safeAreaPadding(.trailing, adjustedPadding.trailing)
  }
}

extension WeightedPaddingModifier {
  var adjustedPadding:
    (
      top: CGFloat?,
      bottom: CGFloat?,
      leading: CGFloat?,
      trailing: CGFloat?
    )
  {
    /// Calculate vertical padding - always the base padding value
    let paddingV = padding

    /// Calculate horizontal padding with bias applied directly
    /// This way horizontalBias represents a direct multiplier
    let paddingH = padding * horizontalBias

    guard let excludedEdge else {
      /// Apply full padding to all edges when no edge is excluded
      return (paddingV, paddingV, paddingH, paddingH)
    }

    switch excludedEdge {
      case .top:
        return (nil, paddingV, paddingH, paddingH)

      case .bottom:
        return (paddingV, nil, paddingH, paddingH)

      case .leading:
        return (paddingV, paddingV, nil, paddingH)

      case .trailing:
        return (paddingV, paddingV, paddingH, nil)
    }
  }
}

extension View {
  public func weightedPadding(
    _ padding: CGFloat,
    horizontalBias: CGFloat = 1.4,
    opticalCentreBias: CGFloat = 1.2,
    excludedEdge: Edge? = nil
  ) -> some View {
    self.modifier(
      WeightedPaddingModifier(
        padding: padding,
        horizontalBias: horizontalBias,
        opticalCentreBias: opticalCentreBias,
        excludedEdge: excludedEdge
      )
    )
  }
}
