//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SharedHelpers
import BaseTypes

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
}

extension Box {

  public var plainText: String {
    /// Flatten every component’s logical lines
    let allLineTypes: [Box.Line] = allComponents.flatMap { $0.makeLines() }

    /// Build *all* visual line stacks (including multi-line text expansion)
    var globalRowIndex = 0
    var stacks: [StringStack] = []

    for lineType in allLineTypes {
      /// Expand this logical line into however many visual rows it produces
      let subStacks: [StringStack] = lineType.buildStack(
        using: engine,
        startingAt: &globalRowIndex,
        rowCount: allLineTypes.count
      )

      stacks.append(contentsOf: subStacks)
    }

    return StringStack.joined(stacks, along: .vertical).string
  }

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
