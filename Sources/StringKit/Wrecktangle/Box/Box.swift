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
  let components: [any Component]

  public init(
    width: Int = 20,
    height: Int? = nil,
    theme: Theme = .default,
    @BoxBuilder content: () -> [any Component]
  ) {
    self.config = Config(w: width, h: height, theme: theme)
    self.components = content()
  }

  public var plainText: String {
    let engine = Box.Engine(config)
    let comps = [Box.Top()] + components + [Box.Bottom()]
    let lines = comps.flatMap { $0.makeLines() }

    return lines.buildString(using: engine)
  }
}

extension Box: Equatable {
  public static func == (lhs: Box, rhs: Box) -> Bool {
    lhs.config.width == rhs.config.width
      && lhs.config.theme == rhs.config.theme
      && lhs.components.count == rhs.components.count
  }
}

extension Box {
  func debugString(_ lines: [Box.LineType]) -> String {
    let linesDebug = lines.reduce(into: "") { partialResult, line in
      partialResult += line.description + "\n"
    }
    return "/// Lines:\n\n\(linesDebug)\n///\n"
  }

}
