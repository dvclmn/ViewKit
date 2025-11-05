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
  let engine: Box.Engine

  public init(
    width: Int = 20,
    height: Int? = nil,
    theme: Theme = .default,
    @BoxBuilder content: () -> [any Component]
  ) {
    let config = Config(w: width, h: height, theme: theme)
    self.config = config
    self.components = content()
    self.engine = Box.Engine(config)
  }

  public var plainText: String {

    let allLines = allComponents.flatMap { $0.makeLines() }

    let final = allLines.enumerated().map {
      index,
      lineType in
      
      let pos = Box.PositionContext(
        i: index,
        rowCount: allLines.count
      )
      let result = lineType.buildString(using: engine, at: pos)
      
//      return index.toString
      return index.toString + result
//      return lineType.buildString(using: engine, at: pos)
    }
    return final.joined("\n")
  }
}

extension Box {

  private var allComponents: [any Component] {
    [Box.Top()] + components + [Box.Bottom()]
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
extension Box: Equatable {
  public static func == (lhs: Box, rhs: Box) -> Bool {
    lhs.config.width == rhs.config.width
      && lhs.config.theme == rhs.config.theme
      && lhs.components.count == rhs.components.count
  }
}
