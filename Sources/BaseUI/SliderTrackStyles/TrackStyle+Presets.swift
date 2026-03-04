//
//  TrackStyle+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import ColourKit
import CoreTools
import SwiftUI
import UIPrimitives

/// A quick patch to support the existing shape, may split out into
/// nicer structs or something one day
public struct TrackStyleShapeProvider: SliderTrackShapeStyleProvider {
  private let style: TrackStyle
  public init(_ style: TrackStyle) { self.style = style }

  public func makeBackgroundStyle(configuration: SliderTrackConfiguration) -> AnyShapeStyle {
    style.shape()
  }
}

@MetaEnum
public enum TrackStyle {
  case rgb(RGBColour, RGBComponent)
  case hsv(HSVColour, HSVComponent)
  case opacityCheckboard(any ColourModel)
  case clear
  case gradient(LinearGradient)

  func shape() -> AnyShapeStyle {
    //  func shape() -> some ShapeStyle {
    switch self {
      case .rgb(let colour, let component):
        return AnyShapeStyle(component.sliderTrackGradient(colour: colour))

      case .hsv(let colour, let component):
        let gradient =
          switch component {
            case .hue: LinearGradient.rainbow()
            case .saturation:
              LinearGradient(
                colors: [.gray, Color(hue: colour.hue, saturation: 1.0, brightness: 1.0)],
                startPoint: .leading,
                endPoint: .trailing
              )
            case .brightness:
              LinearGradient(
                colors: [.black, colour.hueSatOnly.toColour],
                startPoint: .leading,
                endPoint: .trailing
              )
            case .alpha:
              preconditionFailure("Don't pass alpha to create a slider track gradient")
          }
        return AnyShapeStyle(gradient)

      case .opacityCheckboard(let colour):
        let gradient = LinearGradient(
          colors: [.clear, colour.toColour],
          startPoint: .leading,
          endPoint: .trailing
        )
        return AnyShapeStyle(gradient)

      case .clear:
        return AnyShapeStyle(Color.clear)

      case .gradient(let gradient):
        return AnyShapeStyle(gradient)
    }
  }
}

//extension TrackFillStyle {
//  public static var clearBG: TrackFillStyle {
//    TrackFillStyle(
//      fill: AnyShapeStyle(Color.accentColor),
//      background: AnyShapeStyle(Color.clear)
//    )
//  }
//  public static var opacitySlider: TrackFillStyle {
//    TrackFillStyle(
//      fill: nil,
//      foreground: AnyShapeStyle(
//        LinearGradient(
//          colors: [.clear, .white],
//          startPoint: .leading,
//          endPoint: .trailing
//        )
//      ),
//      background: .checkerboard()
//    )
//  }
//  public static var hueRainbow: TrackFillStyle {
//    TrackFillStyle(
//      fill: nil,
//      foreground: nil,
//      //      background: nil
//      background: AnyShapeStyle(LinearGradient.rainbow())
//    )
//  }
//
//  public static func saturation(hue: Double) -> TrackFillStyle {
//    //  public static func saturation(_ hue: Color) -> TrackFillStyle {
//    TrackFillStyle(
//      fill: nil,
//      foreground: nil,
//      //      background: nil
//      background: AnyShapeStyle(
//        LinearGradient(
//          colors: [.gray, Color(hue: hue, saturation: 1.0, brightness: 1.0)],
//          startPoint: .leading,
//          endPoint: .trailing
//        )
//      )
//    )
//  }
//  public static func brightness(_ colour: Color) -> TrackFillStyle {
//    TrackFillStyle(
//      fill: nil,
//      foreground: nil,
//      //      background: nil
//      background: AnyShapeStyle(
//        LinearGradient(
//          colors: [.black, colour],
//          startPoint: .leading,
//          endPoint: .trailing
//        )
//      )
//    )
//  }
//
//  public static func rgb(_ colour: RGBColour, for component: RGBComponent) -> TrackFillStyle {
//    //  public static func rgb(_ colour: RGBColour) -> TrackFillStyle {
//    TrackFillStyle(
//      fill: nil,
//      foreground: nil,
//      //      background: nil
//      background: AnyShapeStyle(
//        component.sliderTrackGradient(colour: colour)
//      )
//      //        AnyShapeStyle(
//      //        LinearGradient(
//      //          colors: [.black, colour],
//      //          startPoint: .leading,
//      //          endPoint: .trailing
//      //        )
//      //      )
//    )
//  }
//
//}
