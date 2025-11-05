//
//  Env+BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import StringShared
import SwiftUI

extension EnvironmentValues {
  @Entry public var glyphSet: Box.GlyphSet = .rounded
  @Entry public var frameStyle: Box.FrameStyle = .single
  @Entry public var metrics: Box.Metrics = []
  @Entry public var gridWidth: Int? = nil
  @Entry public var gridHeight: Int? = nil
  @Entry public var isShowingGridGuide: Bool = false
}

extension View {
  public func setBoxStyle(
    glyphs: Box.GlyphSet,
    frame: Box.FrameStyle,
    metrics: Box.Metrics
  ) -> some View {
    self
      .environment(\.glyphSet, glyphs)
      .environment(\.frameStyle, frame)
      .environment(\.metrics, metrics)
  }

  /// This only sets `gridWidth`/`gridHeight` environment
  /// values. It does not apply a `.frame()` modifier.
  public func setGridFrame(
    _ width: Int? = nil,
    _ height: Int? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self
      .environment(\.gridWidth, width)
      .environment(\.gridHeight, height)
  }
}
