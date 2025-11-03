//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public struct Box: Sendable {

  let width: Int
  let theme: Theme
  let components: [any Component]

  public init(
    width: Int = 20,
    theme: Theme = .default,
    @BoxBuilder content: () -> [any Component]
  ) {
    self.width = width
    self.theme = theme
    self.components = content()
  }

  public var plainText: String {
    let engine = Box.Engine(
      width: width,
      height: nil,
      theme: theme
    )
    let lines = components.flatMap { $0.makeLines(using: engine) }
    let stack = Box.Line.joined(lines: lines, with: theme)
    return stack.string
  }
}

extension Box: Equatable {
  public static func == (lhs: Box, rhs: Box) -> Bool {
    lhs.width == rhs.width
      && lhs.theme == rhs.theme
      && lhs.components.count == rhs.components.count
  }

}

//extension Box where [Component]: Codable {
//
//}
