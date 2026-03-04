//
//  TrackStyle+Env.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var sliderTrackStyle: AnySliderTrackStyle = .default
}

extension View {
  public func sliderTrackStyle<S: SliderTrackStyle>(_ style: S) -> some View {
    environment(\.sliderTrackStyle, AnySliderTrackStyle(style))
  }
}
