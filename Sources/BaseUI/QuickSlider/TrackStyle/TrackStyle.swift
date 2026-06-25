//
//  TrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public protocol SliderTrackStyle {
  associatedtype Body: View
  typealias Configuration = SliderTrackConfiguration
  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

struct AnySliderTrackStyle<Content: View>: SliderTrackStyle {
  private let _makeBody: (Configuration) -> Content
  typealias Body = Content

  init(_ makeBody: @escaping (Configuration) -> Content) {
    self._makeBody = makeBody
  }

  init<S: SliderTrackStyle>(_ style: S) where S.Body == Content {
    self._makeBody = { configuration in
      style.makeBody(configuration: configuration)
    }
  }

  @ViewBuilder func makeBody(configuration: Configuration) -> Content {
    _makeBody(configuration)
  }
}

extension SliderTrackStyle {
  func eraseToAnySliderTrackStyle() -> AnySliderTrackStyle<Body> {
    AnySliderTrackStyle(self)
  }
}
