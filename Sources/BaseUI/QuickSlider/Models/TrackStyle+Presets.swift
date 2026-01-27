//
//  TrackStyle+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import SwiftUI

extension TrackFillStyle {
  public static var clearBG: TrackFillStyle {
    TrackFillStyle(
      fill: AnyShapeStyle(Color.accentColor),
      background: AnyShapeStyle(Color.clear)
    )
  }
  public static var opacitySlider: TrackFillStyle {
    TrackFillStyle(
      fill: nil,
      foreground: AnyShapeStyle(
        LinearGradient(
          colors: [.clear, .white],
          startPoint: .leading,
          endPoint: .trailing
        )
      ),
      background: .checkerboard()
    )
  }
  public static var hueRainbow: TrackFillStyle {
    TrackFillStyle(
      fill: nil,
      foreground: nil,
      //      background: nil
      background: AnyShapeStyle(LinearGradient.rainbow())
    )
  }

  public static func saturation(hue: Double) -> TrackFillStyle {
    //  public static func saturation(_ hue: Color) -> TrackFillStyle {
    TrackFillStyle(
      fill: nil,
      foreground: nil,
      //      background: nil
      background: AnyShapeStyle(
        LinearGradient(
          colors: [.gray, Color(hue: hue, saturation: 1.0, brightness: 1.0)],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
    )
  }
  public static func brightness(_ colour: Color) -> TrackFillStyle {
    TrackFillStyle(
      fill: nil,
      foreground: nil,
      //      background: nil
      background: AnyShapeStyle(
        LinearGradient(
          colors: [.black, colour],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
    )
  }

  public static func rgb(_ colour: RGBColour, for component: RGBComponent) -> TrackFillStyle {
    //  public static func rgb(_ colour: RGBColour) -> TrackFillStyle {
    TrackFillStyle(
      fill: nil,
      foreground: nil,
      //      background: nil
      background: AnyShapeStyle(
        component.sliderTrackGradient(colour: colour)
      )
      //        AnyShapeStyle(
      //        LinearGradient(
      //          colors: [.black, colour],
      //          startPoint: .leading,
      //          endPoint: .trailing
      //        )
      //      )
    )
  }

}
