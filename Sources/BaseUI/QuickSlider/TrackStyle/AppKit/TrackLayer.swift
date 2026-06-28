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
  public enum Layer {
    case colour(ResolvedTrackColour)
    case linearGradient([GradientStop])
    case checkerboard(Checkerboard)
  }
}

// MARK: - Checkerboard
extension AppKitSliderTrack {
  public struct Checkerboard {
    public var primary: ResolvedTrackColour
    public var secondary: ResolvedTrackColour
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
