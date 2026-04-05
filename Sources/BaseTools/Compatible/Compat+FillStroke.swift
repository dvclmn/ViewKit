//
//  Compat+FillStroke.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/12/2025.
//

import SwiftUI

public struct FilledShape<
  S: InsettableShape,
  Style: ShapeStyle,
  StyleStroke: ShapeStyle
>: View {
  let shape: S
  let content: Style
  let strokeColour: AnyShapeStyle
  let lineWidth: CGFloat

  public init(
    _ shape: S,
    style content: Style,
    strokeColour: StyleStroke? = nil,
    lineWidth: CGFloat = 1.0
  ) {
    self.shape = shape
    self.content = content
    self.strokeColour = strokeColour.map { AnyShapeStyle($0) } ?? .clear
    self.lineWidth = lineWidth
  }

  public var body: some View {
    if #available(iOS 17.0, macOS 14.0, *) {
      shape
        .fill(content)
        .stroke(strokeColour, lineWidth: lineWidth)

    } else {
      shape
        .strokeBorder(strokeColour, lineWidth: lineWidth)
        .background(shape.fill(content))
    }
  }
}
