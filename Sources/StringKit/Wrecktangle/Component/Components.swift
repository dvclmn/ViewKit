//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

extension Box {
  public struct Top: Component {
    public init() {}
    public func makeLines(using builder: Box.Builder) -> [Box.Line] {
      [builder.structureLine(type: .top)]
    }
  }

  public struct Divider: Component {
    public init() {}
    public func makeLines(using builder: Box.Builder) -> [Box.Line] {
      [builder.structureLine(type: .divider())]
    }
  }

  public struct Bottom: Component {
    public init() {}
    public func makeLines(using builder: Box.Builder) -> [Box.Line] {
      [builder.structureLine(type: .bottom)]
    }
  }

  public struct Text: Component {
    let content: String
    public init(_ content: String) { self.content = content }

    public func makeLines(using builder: Box.Builder) -> [Box.Line] {
      builder.textLines(content: content)
    }
  }

  public struct Header: Component {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines(using builder: Box.Builder) -> [Box.Line] {
      [
        builder.structureLine(type: .top),
        builder.textLine(content: text),
        builder.structureLine(type: .divider()),
      ]
    }
  }
  
  public struct List: Component {
    let items: [Component]
    
    public init(@BoxBuilder content: () -> [Component]) {
      self.items = content()
    }
    
    public func makeLines(using builder: Box.Builder) -> [Box.Line] {
      items
        .flatMap { $0.makeLines(using: builder) }
        .flatMap { $0 } // Flatten any nested arrays
    }
  }
}
