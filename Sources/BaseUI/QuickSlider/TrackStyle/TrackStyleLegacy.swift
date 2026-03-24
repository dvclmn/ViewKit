//
//  TrackStyleLegacy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public struct DefaultSliderTrackStyle: SliderTrackStyle {
  public init() {}
  public func makeBody(configuration: Configuration) -> some View {
    RoundedRectangle(cornerRadius: 8, style: .continuous)
      .fill(.secondary.opacity(0.25))
  }
}

public struct AnySliderTrackStyleBox: SliderTrackStyle {
  public typealias Body = AnyView
  private let _makeBody: (Configuration) -> AnyView
  
  public init<S: SliderTrackStyle>(_ style: S) {
    self._makeBody = { configuration in
      AnyView(style.makeBody(configuration: configuration))
    }
  }
  
  @ViewBuilder public func makeBody(configuration: Configuration) -> AnyView {
    _makeBody(configuration)
  }
}

extension SliderTrackStyle {
  /// Erase a concrete `SliderTrackStyle` to a non-generic box suitable for use in Environment.
  public func eraseToEnvironmentTrackStyle() -> AnySliderTrackStyleBox {
    AnySliderTrackStyleBox(self)
  }
}
