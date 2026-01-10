//
//  Pretty+Array.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

// MARK: - Collections

extension Array: PrettyPrintable where Element: PrettyPrintable {
  public func pretty(
    _ config: PrettyPrintConfig,
    depth: Int
  ) -> String {
    guard depth < config.maxDepth else {
      return "\(config.arrayPrefix)...\(config.arraySuffix)"
    }

    guard !isEmpty else {
      return "\(config.typeName(self))\(config.arrayPrefix)\(config.arraySuffix)"
    }

    let shouldCompact = config.compactCollections && count <= config.compactThreshold

    if shouldCompact {
      let items = map { $0.pretty(config, depth: depth + 1) }
      return
        "\(config.typeName(self))\(config.arrayPrefix)\(items.joined(separator: "\(config.itemSeparator) "))\(config.arraySuffix)"
    }

    let ind = config.indent(depth)
    let nextInd = config.indent(depth + 1)

    let items = map { element in
      "\(nextInd)\(element.pretty(config, depth: depth + 1))"
    }.joined(separator: config.itemSeparator + "\n")

    return """
      \(config.typeName(self))\(config.arrayPrefix)
      \(items)
      \(ind)\(config.arraySuffix)
      """
  }
}
