//
//  GraphicsContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import BasePrimitives
//import InteractionKit
import SwiftUI

extension GraphicsContext {




  // MARK: - Dashed Stroke
  public func dashedStroke(
    _ path: Path,
    colour: Color,
    strokeWidth: CGFloat,
    style: StrokeDashStyle = .dots,
    gap: CGFloat = 3,
  ) {
    self.stroke(
      path,
      with: .color(colour),
      style: StrokeStyle.dashed(strokeWidth: strokeWidth, style: style, gap: gap)
    )
  }

  public func fillCanvas(
    with colour: Color,
    in size: CGSize,
  ) {
    let path = Path(fromSize: size)
    self.fill(path, with: .color(colour))
  }

  //  public func unitSize(from domain: GridFontDomain) -> CGSize? {
  //    domain.unitSize(in: environment)
  //  }

}
