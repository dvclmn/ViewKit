//
//  TrackLayer.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import Foundation

// MARK: - Layer
extension AppKitSliderTrack {
  /// A drawing layer in an ``AppKitSliderTrack``.
  public enum Layer: Equatable {
    /// A solid colour fill.
    case colour(ResolvedTrackColour)
    /// A left-to-right gradient with explicit stops.
    case linearGradient([GradientStop])
    /// A checkerboard, commonly used beneath an alpha gradient.
    case checkerboard(Checkerboard)
  }
}

// MARK: - Checkerboard
extension AppKitSliderTrack {
  /// Parameters for a checkerboard background layer.
  public struct Checkerboard: Equatable {
    /// The colour used by alternating squares.
    public var primary: ResolvedTrackColour
    /// The colour used by the remaining squares.
    public var secondary: ResolvedTrackColour
    /// The side length of each square in points.
    public var squareLength: CGFloat

    public init(
      primary: ResolvedTrackColour = .white,
      secondary: ResolvedTrackColour = .init(white: 0.66),
      squareLength: CGFloat = 4.0,
    ) {
      self.primary = primary
      self.secondary = secondary
      self.squareLength = squareLength
    }
  }
}

#endif
