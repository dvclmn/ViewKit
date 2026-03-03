//
//  Env+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import BasePrimitives
import SwiftUI

extension EnvironmentValues {

  @Entry public var gridDimensions: GridDimensions?
  @Entry public var gridFont: GridFont?
  @Entry public var isShowingCellNumbers: Bool = false
  @Entry public var gridLineColour: Color = .cyan.opacity(0.17)
  @Entry public var gridLineWidth: CGFloat = 1.0

  /// Note: This hard-codes / assumes `unitSize` (not `asciiUnitSize` nor
  /// `activeUnitSize`). Derives anchor from `canvasAnchor` Env value.
  public var gridGeometry: GridGeometry? {
    guard let viewportRect, let gridDimensions, let unitSize else { return nil }
    return GridGeometry(
      viewportRect: viewportRect,
      dimensions: gridDimensions,
      unitSize: unitSize,
      anchor: canvasAnchor
    )
  }

  public var gridCanvasSize: CGSize? {
    guard let unitSize, let gridDimensions else { return nil }
    return gridDimensions.toScreenSize(using: unitSize)
  }
}
