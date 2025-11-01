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
  //  @Entry public var glyphSet: Box.GlyphSet? = nil
  @Entry public var frameStyle: Box.Theme.FrameStyle = .single
  //  @Entry public var frameStyle: Box.Theme.FrameStyle? = nil
  @Entry public var gridWidth: Int? = nil
  @Entry public var gridHeight: Int? = nil
}

extension View {
  public func boxStyle(
    glyphs: Box.GlyphSet,
    frame: Box.Theme.FrameStyle
  ) -> some View {
    self
      .environment(\.glyphSet, glyphs)
      .environment(\.frameStyle, frame)
  }

  public func gridFrame(
    _ width: Int? = nil,
    _ height: Int? = nil,
    alignment: Alignment = .center
  ) -> some View {
    self
      .environment(\.gridWidth, width)
      .environment(\.gridHeight, height)
  }
}
