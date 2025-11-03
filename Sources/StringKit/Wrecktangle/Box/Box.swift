//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public struct Box: Sendable, Equatable {
  let width: Int
  let theme: Theme
  let components: [Component]
  
  public init(
    width: Int,
    theme: Theme = .default,
    @BoxBuilder content: () -> [Component]
  ) {
    self.width = width
    self.theme = theme
    self.components = content()
  }
  
  public func draw() -> String {
    let lines = components.flatMap { $0.makeLines() }
    let stack = Box.Line.joined(lines: lines, with: theme)
    return stack.string
  }
}

extension Box where [Component]: Codable {
  
}
