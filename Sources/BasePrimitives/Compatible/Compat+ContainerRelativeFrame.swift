//
//  Compat+ContainerRelativeFrame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI

extension View {
  @ViewBuilder
  public func containerRelativeFrameCompatible(
    _ axes: Axis.Set,
    count: Int,
    span: Int = 1,
    spacing: CGFloat,
    alignment: Alignment = .center
  ) -> some View {
    if #available(macOS 14, iOS 17, *) {
      containerRelativeFrame(
        axes,
        count: count,
        span: span,
        spacing: spacing,
        alignment: alignment
      )
    } else {
      self
    }
  }
}
