//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation


extension Box {
  public protocol Component: Codable, Sendable, Equatable {
    func makeLines(using engine: Box.Engine) -> StringStack
//    func makeLines(using engine: Box.Engine) -> [Box.LineType]
  }
}

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> StringStack {
//      engine.structureLines(type: .top)
//      Box.StructureType.top.line(toWidth: <#T##Int#>, using: <#T##Box.Theme#>)
      [engine.structureLine(type: .top)]
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> StringStack {
      engine.structureLines(type: .divider)
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> StringStack{
      engine.structureLines(type: .bottom)
    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }

    public func makeLines(using engine: Box.Engine) -> StringStack {
      //      print("Created a Box.Text: \(content)")
      return engine.textLines(content)
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines(using engine: Box.Engine) -> StringStack {
//      engine.structureLine(type: .top)
        engine.textLines(text)
        + engine.structureLines(type: .divider)

    }
  }

}
