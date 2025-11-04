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

    let finalLines = [Box.Top()] + components + [Box.Bottom()]
    
    let lines = finalLines.flatMap { $0.makeLines(using: engine) }
    
    let linesString = lines.reduce(into: "") { partialResult, line in
      partialResult += line.description + "\n"
    }
    print("/// Lines:\n\n\(linesString)\n///\n")
    let stringResult = lines.buildString(using: engine)
    
    return stringResult
    
//    let stack = Box.LineType.joined(width: width, lines: lines, with: theme)
    
    
    
//    let stringResult = stack.string

//    return "wait one sec"
//    return stringResult

  }
}

extension Box: Equatable {
  public static func == (lhs: Box, rhs: Box) -> Bool {
    lhs.config.width == rhs.config.width
    && lhs.config.theme == rhs.config.theme
      && lhs.components.count == rhs.components.count
  }

}

//extension Box where [Component]: Codable {
//
//}

