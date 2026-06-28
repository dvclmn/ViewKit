//
//  ColourTrackStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/3/2026.
//

import ColourTools
import CoreTools
import GraphicsKit
// import LayoutKit
import SwiftUI
import ViewTools

public struct RGBTrackStyle: SliderTrackStyle {

  let colour: RGBColour
  let component: RGBComponent

  public func makeBody(configuration: Configuration) -> some View {
    Rectangle()
      .fill(.opacityBackground)
      .fill(component.sliderTrackGradient(colour: colour))
  }
}

public struct HSVTrackStyle: SliderTrackStyle {

  let colour: HSVColour
  let component: HSVComponent

  public func makeBody(configuration: Configuration) -> some View {
    Rectangle()
      .fill(.opacityBackground)
      .fill(gradient)
  }
}

extension HSVTrackStyle {
  private var gradient: LinearGradient {
    let gradient =
      switch component {
        case .hue: LinearGradient.rainbow()
        case .saturation:
          LinearGradient(
            colors: [.gray, Color(hue: colour.hue, saturation: 1.0, brightness: 1.0)],
            startPoint: .leading,
            endPoint: .trailing,
          )
        case .brightness:
          LinearGradient(
            colors: [.black, colour.hueSatOnly.toColour],
            startPoint: .leading,
            endPoint: .trailing,
          )
        case .alpha:
          preconditionFailure("Don't pass alpha to create a slider track gradient")
      }
    return gradient
    //    return AnyShapeStyle(gradient)
  }
}

#if os(macOS)
extension RGBTrackStyle: AppKitSliderTrackStyle {
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

extension HSVTrackStyle: AppKitSliderTrackStyle {
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
