//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SharedHelpers

public struct Box: Sendable {

  let config: Config
//  let width: Int
//  let height: Int?
//  let theme: Theme
  let components: [any Component]

  public init(
    width: Int = 20,
    height: Int? = nil,
    theme: Theme = .default,
    @BoxBuilder content: () -> [any Component]
  ) {
//    self.width = width
//    self.height = height
//    self.theme = theme
    self.config = Config(w: width, h: height, theme: theme)
    self.components = content()
  }

  public var plainText: String {
    let engine = Box.Engine(
      width: width,
      height: nil,
      theme: theme
    )

//    let containsHeader = components.contains(where: { comp in
//      comp is Box.Header
//    })

//    let boxTopIfNeeded = containsHeader ? [] : [Box.Top()]

    let finalLines = [Box.Top()] + components + [Box.Bottom()]
    let lines = finalLines.flatMap { $0.makeLines(using: engine) }
    let stack = Box.LineType.joined(width: width, lines: lines, with: theme)
    let stringResult = stack.string

    return stringResult

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
