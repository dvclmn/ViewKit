//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

public typealias ComponentOutput = [Box.LineType]

extension Box {
  public protocol Component: Codable, Sendable, Equatable {
    func makeLines() -> ComponentOutput
    //    func makeLines(using engine: Box.Engine) -> ComponentOutput
  }
}

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines() -> ComponentOutput {
      [LineType.structure(.top)]
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines() -> ComponentOutput {
      [
        LineType.structure(.divider)
      ]
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines() -> ComponentOutput {
      [LineType.structure(.bottom)]

    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }

    public func makeLines() -> ComponentOutput {
      let textLine = Box.TextLine(
        text: content,
        leading: .vertical(.leading),
        trailing: .vertical(.trailing)
      )
      return [Box.LineType.text(textLine)]
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines() -> ComponentOutput {
      return Box.Text(text).combined(with: Box.Divider())
    }
  }
}

extension Box.Component {
  func combined(with other: any Box.Component) -> ComponentOutput {
    let lhsLines = self.makeLines()
    let rhsLines = other.makeLines()
    return lhsLines + rhsLines
  }
}
