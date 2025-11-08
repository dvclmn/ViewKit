//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

/// Having this as an array seems neccesary really only for the Header
/// (at this point), as it needs to
public typealias ComponentOutput = [Box.Line]
//public typealias ComponentOutput = [Box.LineType]

extension Box {
  public protocol Component: Codable, Sendable, Equatable {
    func makeLines() -> ComponentOutput
  }
}

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines() -> ComponentOutput { [Line.create(.structure(.top))] }
    //    public func makeLines() -> ComponentOutput { [LineType.structure(.top)] }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines() -> ComponentOutput { [Line.create(.structure(.divider))] }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines() -> ComponentOutput { [Line.create(.structure(.bottom))] }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }
    public func makeLines() -> ComponentOutput { [Line.create(.text(content))] }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines() -> ComponentOutput { Box.Text(text).combined(with: Box.Divider()) }
  }
}

extension Box.Component {
  func combined(with other: any Box.Component) -> ComponentOutput {
    let lhsLines = self.makeLines()
    let rhsLines = other.makeLines()
    return lhsLines + rhsLines
  }
}
