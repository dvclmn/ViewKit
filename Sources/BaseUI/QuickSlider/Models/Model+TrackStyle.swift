//
//  Model+TrackStyle.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI

@available(macOS 14.0, *)
public enum SliderType {
  case native
  case custom(TrackFillStyle)
}

@available(macOS 14.0, *)
public struct TrackFillStyle {
  let fill: AnyShapeStyle
  /// This could drive more complex fills,
  /// such as a linear gradient atop the
  /// checkerboard of Opacity Slider
  let foreground: AnyShapeStyle
  let background: AnyShapeStyle
  
  public init(
    fill: AnyShapeStyle? = AnyShapeStyle(Color.accentColor),
    foreground: AnyShapeStyle? = nil,
    background: AnyShapeStyle? = AnyShapeStyle(.quaternary)
  ) {
    self.fill = fill ?? .clear
    self.foreground = foreground ?? .clear
    self.background = background ?? .clear
  }
}

@available(macOS 14.0, *)
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
        LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing)
      ),
      background: .checkerboard()
    )
  }
  
}
