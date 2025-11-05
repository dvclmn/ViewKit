//
//  LineType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

// MARK: - Main String builder
extension Box.LineType {
  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {
    switch self {
      case .structure(let type):
        return type.parts.buildString(using: engine, at: position)
      case .text(let line):
        return line.buildString(using: engine, at: position)
    }
  }
}
