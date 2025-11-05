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
//    let lines = componentsWithStructure.flatMap { $0.makeLines() }

    return lines.buildString(using: engine)
  }
}

extension Box {
  
  var componentsWithStructure: [any Component] {
    [Box.Top()] + components + [Box.Bottom()]
  }
  
  func linesFromComponents() -> [Box.LineType] {
//    let rawLines = comps.flatMap { $0.makeLines(using: engine) }
    let rawLines = componentsWithStructure.flatMap { $0.makeLines() }
    
    let linesWithContext = rawLines.enumerated().map { index, line in
      (index, line)
    }
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
