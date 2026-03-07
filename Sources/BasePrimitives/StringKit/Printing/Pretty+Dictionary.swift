//
//  Pretty+Dictionary.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

extension Dictionary: PrettyPrintable where Key: PrettyPrintable, Value: PrettyPrintable {
  public func pretty(
    _ config: PrettyPrintConfig,
    depth: Int
  ) -> String {
    guard depth < config.maxDepth else {
      return "\(config.dictPrefix)...\(config.dictSuffix)"
    }

    guard !isEmpty else {
      return "\(config.typeName(self))\(config.dictPrefix)\(config.dictSuffix)"
    }

    let shouldCompact = config.compactCollections && count <= config.compactThreshold

    /// Sort keys for consistent output (if possible)
    let sortedPairs = sorted { "\($0.key)" < "\($1.key)" }

    if shouldCompact {
      let items = sortedPairs.map { key, value in
        "\(key.pretty(config, depth: depth + 1))\(config.keyValueSeparator)\(value.pretty(config, depth: depth + 1))"
      }
      return
        "\(config.typeName(self))\(config.dictPrefix)\(items.joined(separator: "\(config.itemSeparator) "))\(config.dictSuffix)"
    }

    let ind = config.indent(depth)
    let nextInd = config.indent(depth + 1)

    let items = sortedPairs.map { key, value in
      let keyDesc = key.pretty(config, depth: depth + 1)
      let valueDesc = value.pretty(config, depth: depth + 1)
      return "\(nextInd)\(keyDesc)\(config.keyValueSeparator)\(valueDesc)"
    }.joined(separator: config.itemSeparator + "\n")

    return """
      \(config.typeName(self))\(config.dictPrefix)
      \(items)
      \(ind)\(config.dictSuffix)
      """
  }
}

