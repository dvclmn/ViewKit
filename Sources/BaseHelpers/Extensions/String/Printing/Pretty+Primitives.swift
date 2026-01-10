//
//  Pretty+Primitives.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

// MARK: - Basic Types

extension String: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\"\(self)\""
  }
}
extension Character: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\"\(self)\""
  }
}

extension Int: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\(self)"
  }
}

extension Double: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\(self)"
  }
}

extension Bool: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\(self)"
  }
}
