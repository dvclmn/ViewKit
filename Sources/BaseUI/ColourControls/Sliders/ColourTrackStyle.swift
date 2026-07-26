//
//  ColourTrackStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/3/2026.
//

#if os(macOS)
import ColourTools
import SwiftUI

/// An AppKit track that edits one RGB component while preserving the others.
public struct RGBTrackStyle: AppKitSliderTrackStyle {
  let colour: RGBColour
  let component: RGBComponent

  public init(colour: RGBColour, component: RGBComponent) {
    self.colour = colour
    self.component = component
  }

  public func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    switch component {
      case .red:
        AppKitSliderTrack.linearGradient([
          ResolvedTrackColour(red: 0.0, green: colour.green, blue: colour.blue),
          ResolvedTrackColour(red: 1.0, green: colour.green, blue: colour.blue),
        ])

      case .green:
        AppKitSliderTrack.linearGradient([
          ResolvedTrackColour(red: colour.red, green: 0.0, blue: colour.blue),
          ResolvedTrackColour(red: colour.red, green: 1.0, blue: colour.blue),
        ])

      case .blue:
        AppKitSliderTrack.linearGradient([
          ResolvedTrackColour(red: colour.red, green: colour.green, blue: 0.0),
          ResolvedTrackColour(red: colour.red, green: colour.green, blue: 1.0),
        ])

      case .alpha:
        AppKitSliderTrack.opacityGradient(
          ResolvedTrackColour(red: colour.red, green: colour.green, blue: colour.blue)
        )
    }
  }
}

/// An AppKit track that edits one HSV component while preserving the others.
public struct HSVTrackStyle: AppKitSliderTrackStyle {
  let colour: HSVColour
  let component: HSVComponent

  public init(colour: HSVColour, component: HSVComponent) {
    self.colour = colour
    self.component = component
  }

  public func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    switch component {
      case .hue:
        AppKitSliderTrack.linearGradient([
          ResolvedTrackColour(Color.red),
          ResolvedTrackColour(Color.orange),
          ResolvedTrackColour(Color.yellow),
          ResolvedTrackColour(Color.green),
          ResolvedTrackColour(Color.blue),
          ResolvedTrackColour(Color.indigo),
          ResolvedTrackColour(Color.purple),
          ResolvedTrackColour(Color.pink),
          ResolvedTrackColour(Color.red),
        ])

      case .saturation:
        AppKitSliderTrack.linearGradient([
          .grey,
          ResolvedTrackColour(
            hue: colour.hue,
            saturation: 1.0,
            brightness: 1.0,
          ),
        ])

      case .brightness:
        AppKitSliderTrack.linearGradient([
          .black,
          ResolvedTrackColour(
            hue: colour.hue,
            saturation: colour.saturation,
            brightness: 1.0,
          ),
        ])

      case .alpha:
        AppKitSliderTrack.opacityGradient(
          ResolvedTrackColour(
            hue: colour.hue,
            saturation: colour.saturation,
            brightness: colour.brightness,
          )
        )
    }
  }
}
#endif
