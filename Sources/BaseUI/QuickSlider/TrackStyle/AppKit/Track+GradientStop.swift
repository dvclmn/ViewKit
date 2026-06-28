//
//  Track+GradientStop.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import Foundation

extension AppKitSliderTrack {
  public struct GradientStop {
    public var colour: ResolvedTrackColour
    public var location: CGFloat
    
    public init(
      colour: ResolvedTrackColour,
      location: CGFloat,
    ) {
      self.colour = colour
      self.location = location
    }
  }
}

extension AppKitSliderTrack.GradientStop {
  static func evenlySpaced(
    from colours: [ResolvedTrackColour]
  ) -> [Self] {
    guard colours.count > 1 else {
      return colours.map { Self(colour: $0, location: 0.0) }
    }
    
    let divisor = CGFloat(colours.count - 1)
    return colours.enumerated().map { index, colour in
      Self(colour: colour, location: CGFloat(index) / divisor)
    }
  }
}

#endif
