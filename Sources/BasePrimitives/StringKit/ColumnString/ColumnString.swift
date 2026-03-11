//
//  ColumnString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

public struct ColumnString: Sendable, Equatable, Hashable {
  public let content: String
  public let width: Width
  
  public init(content: String, width: Width = .default) {
    self.content = content
    self.width = width
  }
}

extension ColumnString: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(content: value)
  }
}

extension ColumnString {
  public enum Width: Sendable, Equatable, Hashable {
    case fixed(Int)
    case flexible(min: Int = 2, max: Int = Int.max)
    
    public static let `default`: Self = .fixed(3)
  }
}
