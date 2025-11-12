//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

public typealias Components = [Box.Line]

extension Box {
  public protocol Component: Codable, Sendable, Equatable {
    func makeLines() -> Components
  }
}

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines() -> Components {
      [
        Box.Line(
          repeating: .horizontal(.top),
          leading: .corner(.topLeading),
          trailing: .corner(.topTrailing),
        )
      ]
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines() -> Components {
      [
        Box.Line(
          repeating: .horizontal(.interior),
          leading: .join(.leading),
          trailing: .join(.trailing),
        )
      ]
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines() -> Components {
      [
        Box.Line(
          repeating: .horizontal(.bottom),
          leading: .corner(.bottomLeading),
          trailing: .corner(.bottomTrailing),
        )
      ]
    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }
    public func makeLines() -> Components {
      [
        Box.Line(
          text: content,
          leading: .vertical(.leading),
          trailing: .vertical(.trailing),
        )
      ]
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines() -> Components {
      Box.Text(text).combined(with: Box.Divider())
    }
  }
}

extension Box.Component {
  func combined(with other: any Box.Component) -> Components {
    let lhsLines = self.makeLines()
    let rhsLines = other.makeLines()
    return lhsLines + rhsLines
  }
}
