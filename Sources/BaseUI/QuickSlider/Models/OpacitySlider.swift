//
//  OpacitySlider.swift
//  BaseComponents
//
//  Created by Dave Coleman on 16/6/2025.
//

import BasePrimitives
import ColourKit
import GraphicsKit
import SwiftUI

extension Image {
  @MainActor
  static func checkerboard(scale: CGFloat = 10) -> Image {
    let renderer = ImageRenderer(
      content:
        Canvas {
          context,
          size in
          context.drawPattern(
            .checkerboard,
            config: PatternConfiguration(
              size: scale,
              gap: scale,
              primaryColour: .brown,
              secondaryColour: .white
            ),
            in: size
          )
        }
        .frame(width: scale * 2, height: scale * 2)
    )
    renderer.scale = 2.0
    #if canImport(AppKit)
    guard let nsImage = renderer.nsImage else {
      return Image(systemName: "questionmark")
    }
    return Image(nsImage: nsImage)

    #else
    guard let uiImage = renderer.uiImage else {
      return Image(systemName: "questionmark")
    }
    return Image(uiImage: uiImage)

    #endif
  }

}

@MainActor
public struct OpacityShapeStyle: @preconcurrency ShapeStyle {

  let scale: CGFloat
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    ImagePaint(
      image: Image.checkerboard(scale: scale),
      scale: 1.0
    )
  }
}

extension ShapeStyle where Self == OpacityShapeStyle {
  public static func checkerboard(scale: CGFloat = 10) -> Self {
    OpacityShapeStyle(scale: scale)
  }
}

extension AnyShapeStyle {
  public static func checkerboard(scale: CGFloat = 10) -> Self {
    AnyShapeStyle(OpacityShapeStyle(scale: scale))
  }
}
