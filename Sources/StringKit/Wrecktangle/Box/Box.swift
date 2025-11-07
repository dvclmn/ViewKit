//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SharedHelpers

public struct Box: Sendable {
  let components: [any Component]
  let engine: Box.Engine

  public init(
    width: Int = 20,
    height: Int? = nil,
    theme: Theme = .default,
    metrics: Metrics = .lineNumbers,
    @BoxBuilder content: () -> [any Component]
  ) {
    let config = Config(
      w: width,
      h: height,
      theme: theme,
      metrics: metrics
    )
    self.components = content()
    self.engine = Box.Engine(config)
  }

  public var plainText: String {

    /// `allLines` gathers all the components that have been added
    /// from the builder, and flattens them down into an array of ``Box/LineType``
    let allComponents = allComponents.flatMap { $0.makeLines() }

    let lines = allComponents.enumerated().map { index, lineType in

      let pos = Box.PositionContext(i: index, rowCount: allComponents.count)
      let result = lineType.buildBoxLine(using: engine, at: pos)

      return result
    }
    let result = StringStack.joined(lines, along: .vertical).string
    return result
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
    lhs.engine.config.width == rhs.engine.config.width
      && lhs.engine.config.theme == rhs.engine.config.theme
      && lhs.components.count == rhs.components.count
  }
}
