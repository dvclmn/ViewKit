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

  /// Note: This hard-codes `unitSize` (not `asciiUnitSize` nor `activeUnitSize`)
  /// and also assumes a canvas artwork anchor of `center`
  public var gridGeometry: GridGeometry? {
    guard let viewportRect, let gridDimensions, let unitSize else { return nil }
    return GridGeometry(
      viewportRect: viewportRect,
      dimensions: gridDimensions,
      projection: GridProjection(unitSize: unitSize),
      anchor: .center
    )
  }

}

//extension View {
//  public func setGridDimensions(_ width: Int, height: Int) -> some View {
//    self.environment(\.gridDimensions, GridDimensions(width, height))
//  }
//}
