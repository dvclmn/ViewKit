//
//  CanvasBuilder.swift
//  BaseDemos
//
//  Created by Dave Coleman on 2/2/2026.
//

import SwiftUI

public struct CheckerBoardBuilder {
  var rows: [Int] = []
  var cols: [Int] = []

  var debugEnabled: Bool = false

  /// how many cells near the edge to highlight
  var edgeHighlightWidth: Int = 1

  var nearCullAreaThreshold: CGFloat = 2  // in square points

  let invisibleThreshold: Int = 32

  let size: CGSize
  let config: StageViewConfig

  public init(
    size: CGSize,
    config: StageViewConfig
  ) {
    self.size = size
    self.config = config
  }
}
