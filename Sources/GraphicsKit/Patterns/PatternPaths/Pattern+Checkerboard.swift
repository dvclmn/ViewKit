//
//  Pattern+Checkerboard.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import ColourKit
import SwiftUI

extension ShapeStyle where Self == CheckerboardPattern {
  public static func checkerboard(
    primary: RGBColour = .white,
    secondary: RGBColour = .gray,
    scale: CGFloat = 1.0,
    offset: CGPoint = .zero
  ) -> Self {
    CheckerboardPattern(
      primary: primary,
      secondary: secondary,
      scale: scale,
      offset: offset
    )
  }
}

public struct CheckerboardPattern: ShapeStyle {
  let primary: RGBColour
  let secondary: RGBColour
  let scale: CGFloat
  let offset: CGPoint
  //
  //  public init(
  //    primary: RGBColour,
  //    secondary: RGBColour,
  //    scale: CGFloat,
  //    offset: CGPoint,
  //  ) {
  //    self.primary = primary
  //    self.secondary = secondary
  //    self.scale = scale
  //    self.offset = offset
  //  }

  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    ShaderEffect.checkerboard(
      primary: primary,
      secondary: secondary,
      scale: scale,
      offset: offset
    ).shader
  }
}

extension GraphicsContext {

  func drawCheckerboard(
    _ config: PatternConfiguration,
    in size: CGSize,
  ) {
    let rows = Int(ceil(size.height / config.size)) + 1
    let cols = Int(ceil(size.width / config.size)) + 1

    for row in 0..<rows {
      for col in 0..<cols {
        let x = CGFloat(col) * config.size + config.offset.width.truncatingRemainder(dividingBy: config.size)
        let y = CGFloat(row) * config.size + config.offset.height.truncatingRemainder(dividingBy: config.size)

        let rect = CGRect(x: x, y: y, width: config.size, height: config.size)
        let colour =
          (row + col).isMultiple(of: 2) ? config.primaryColour.toColour : config.secondaryColour.toColour
        self.fill(Path(rect), with: .color(colour))
      }
    }
  }
}
