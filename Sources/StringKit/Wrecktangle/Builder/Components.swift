//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .top)]
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .divider)]
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .bottom)]
    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }

    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
//      print("Created a Box.Text: \(content)")
      return engine.textLines(content)
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .top)]
        + engine.textLines(text)
        + [engine.structureLine(type: .divider)]

    }
  }

}
