//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SharedHelpers

public struct Box: Sendable {

  let width: Int
  let height: Int?
  let theme: Theme
  let components: [any Component]

  public init(
    width: Int = 20,
    height: Int? = nil,
    theme: Theme = .default,
    @BoxBuilder content: () -> [any Component]
  ) {
    self.width = width
    self.height = height
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
    
//    print("Lines, from the Builder components: \(lines.)")
//    dump(lines, name: "Box Lines", indent: 2)
    
    let stack = Box.LineType.joined(width: width, lines: lines, with: theme)
//    let stack = Box.Line.joined(lines: lines, with: theme)
    let stringResult = stack.string
    
//    print("String Result: \(stringResult)")
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
