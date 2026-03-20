//
//  Block+IndentedLines.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/2/2026.
//

import Foundation

public struct IndentedLines: Sendable {
  public let title: String?
  public let lines: [String]
  public let separator: String

  public init(
    _ title: String? = nil,
    _ lines: [String]?,
    separator: String = "\n"
  ) {
    self.title = title
    self.lines = lines ?? []
    self.separator = separator
  }
}
