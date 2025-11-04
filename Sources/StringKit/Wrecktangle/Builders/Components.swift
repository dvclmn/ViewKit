//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

public typealias ComponentOutput = [Box.LineType]
//typealias ComponentOutput = StringStack

extension Box {
  public protocol Component: Codable, Sendable, Equatable {
    func makeLines(using engine: Box.Engine) -> ComponentOutput
  }
}

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      //      engine.structureLines(type: .top)
      //      Box.StructureType.top.line(toWidth: <#T##Int#>, using: <#T##Box.Theme#>)
      [engine.structureLine(type: .top)]
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      [
        engine.structureLine(type: .divider)
      ]
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      [
        engine.structureLine(type: .bottom)
      ]
    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }

    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      //      print("Created a Box.Text: \(content)")
      [engine.textLine(content)]
      //      return engine.textLines(content)
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      return Box.Text(text).combined(with: Box.Divider(), using: engine)
    }
  }
}

extension Box.Component {
  func combined(
    with other: any Box.Component,
    using engine: Box.Engine
  ) -> ComponentOutput {
    let lhsLines = self.makeLines(using: engine)
    let rhsLines = other.makeLines(using: engine)
    return lhsLines + rhsLines
  }
}
//public func + (lhs: any Box.Component, rhs: any Box.Component) -> ComponentOutput {
//   let lhsLines = lhs.makeLines(using: .init())
//  let rhsLines = rhs.makeLines(using: .init())
//  return lhsLines + rhsLines
//}
