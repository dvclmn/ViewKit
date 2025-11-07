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

    /// `allComponents` gathers all the components that have been added
    /// from the builder, and flattens them down into an array of ``Box/LineType``
    let stackOutput: [StringStack] = allComponents.map { comp in
      //    let stacks: [StringStack] = allComponents.enumerated().map { index, comp in

      print("All Comps count: \(allComponents.count)")
      //      print("Component count: \(allComponents.count)")

      let boxLines = comp.makeLines()
      print("Box Lines count: \(boxLines.count)")

      let stacks: [StringStack] = boxLines.enumerated().map { index, line in
        print("Stacks index: \(index), line: \(line)")
        let pos = Box.PositionContext(i: index, rowCount: boxLines.count)

        //        let lineStacks: [StringStack] = boxLines.map { line in
        return line.buildBoxLine(using: engine, at: pos)
        //        }

      }

      return StringStack.joined(stacks, along: .vertical)
    }

    //    return stackOutput

    //    let stacks = lines.flatMap(\.self)

    let result = StringStack.joined(stackOutput, along: .vertical).string
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
