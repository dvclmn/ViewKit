//
//  OpacityTrackStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/3/2026.
//

#if os(macOS)
import ColourTools

/// An AppKit checkerboard-backed opacity track for a fixed base colour.
public struct OpacityTrackStyle: AppKitSliderTrackStyle {
  let colour: any ColourModel & SwiftUIColourConvertible

  public init(colour: any ColourModel & SwiftUIColourConvertible) {
    self.colour = colour
  }

  public func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    AppKitSliderTrack.opacityGradient(ResolvedTrackColour(colour.toColour))
  }
}
#endif
