//
//  PrettyPrint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

public protocol PrettyPrintable {
  func prettyDescription(_ config: PrettyPrintConfig, depth: Int) -> String
}

// MARK: - Default Implementation

extension PrettyPrintable {
  public func prettyPrint(_ config: PrettyPrintConfig = .default) {
    print(prettyDescription(config, depth: 0))
  }

  public var prettyDescription: String {
    prettyDescription(.default, depth: 0)
  }
}
