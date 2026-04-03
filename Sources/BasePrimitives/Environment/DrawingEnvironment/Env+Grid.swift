//
//  Env+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import InteractionKit
import SwiftUI

extension EnvironmentValues {

  @Entry public var gridDimensions: GridDimensions?
  @Entry public var gridFont: GridFont?
  @Entry public var isShowingCellNumbers: Bool = false
  @Entry public var gridLineColour: Color = .cyan.opacity(0.17)
  @Entry public var gridLineWidth: CGFloat = 1.0

  public var isGridCanvasReady: Bool {
    unitSize != nil && gridDimensions != nil
  }

  @Entry public var isCellSelectionEnabled: Bool = true

}
