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

extension Box {
  public protocol Component: Codable, Sendable, Equatable {
    func makeLines(using engine: Box.Engine) -> ComponentOutput
  }
}

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      [
        Box.Line(
          .horizontal(.top),
          leading: .corner(.topLeading),
          trailing: .corner(.topTrailing),
          using: engine
        )
      ]
      //      .single(.structure(.top))
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      [
        Box.Line(
          .horizontal(.interior),
          leading: .join(.leading),
          trailing: .join(.trailing),
          using: engine
        )
      ]
      //      .single(.structure(.divider))
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      [
        Box.Line(
          .horizontal(.bottom),
          leading: .corner(.bottomLeading),
          trailing: .corner(.bottomTrailing),
          using: engine
        )
      ]
    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }
    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      [
        Box.Line(
          content,
          leading: .vertical(.leading),
          trailing: .vertical(.trailing),
          using: engine
        )
      ]
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines(using engine: Box.Engine) -> ComponentOutput {
      Box.Text(text).combined(with: Box.Divider(), using: engine)
    }
  }
}

extension Box.Component {
  func combined(with other: any Box.Component, using engine: Box.Engine) -> ComponentOutput {
    let lhsLines = self.makeLines(using: engine)
    let rhsLines = other.makeLines(using: engine)
    return lhsLines + rhsLines
  }
}
