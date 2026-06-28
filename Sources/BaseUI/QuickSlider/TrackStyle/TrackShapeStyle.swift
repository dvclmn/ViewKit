//
//  TrackShapeStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

/// ```
/// let bg = provider.makeBackgroundStyle(configuration: config)
/// RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
///   .fill(bg)
/// ```
/// then optionally overlay/foreground/fill layers if provided
public protocol SliderTrackShapeStyleProvider {
  func makeBackgroundStyle(configuration: SliderTrackConfiguration) -> AnyShapeStyle

  func makeForegroundStyle(configuration: SliderTrackConfiguration) -> AnyShapeStyle?
  func makeFillStyle(configuration: SliderTrackConfiguration) -> AnyShapeStyle?
}

extension SliderTrackShapeStyleProvider {
  public func makeForegroundStyle(configuration: SliderTrackConfiguration) -> AnyShapeStyle? { nil }
  public func makeFillStyle(configuration: SliderTrackConfiguration) -> AnyShapeStyle? { nil }
}
