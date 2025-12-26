//
//  CodeBackground.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/12/2025.
//

import AppKit

public struct CodeBackground: Equatable, Hashable {
  let fill: NSColor
  let stroke: NSColor
  let rounding: CGFloat
  
  public init(
    fill: NSColor = .systemMint.withAlphaComponent(0.1),
    stroke: NSColor = .green.withAlphaComponent(0.4),
    rounding: CGFloat = 3
  ) {
    self.fill = fill
    self.stroke = stroke
    self.rounding = rounding
  }
}
