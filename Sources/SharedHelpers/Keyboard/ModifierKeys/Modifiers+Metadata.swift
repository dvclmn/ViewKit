//
//  Modifiers+Metadata.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import Foundation

//extension ModifierKeys {
//  public func displayName(
//    elements: ModifierDisplayElements,
//    separator: String = " + ",
//    emptyText: String = "None"
//  ) -> String {
//    // Build components for each contained option using the metadata map
//    let presentOptions = ModifierKeys.Options.allCases.filter {
//      self.contains($0)
//    }
//
//    let components: [String] = presentOptions.compactMap { option in
//      guard let meta = ModifierKeys.metadata(for: option) else { return nil }
//      switch elements {
//      case .name:
//        return meta.name
//      case .icon:
//        return meta.symbol
//      case .both:
//        return "\(meta.symbol) \(meta.name)"
//      default:
//        return nil
//      }
//    }
//
//    return components.isEmpty ? emptyText : components.joined(separator: separator)
//  }
//}

//private extension ModifierKeys {
//  // Provide a file-scoped accessor to the private metadata map
//  static func _metadata(for option: ModifierKeys.Options) -> Metadata? {
//    // The metadata dictionary keys are `ModifierKeys` (sets). Create a singleton set for the option.
//    // Use the local metadataLookup dictionary to get the Metadata for the single option
//    return metadataLookup[option]
//  }
//
//  // Build a local lookup keyed by Options to access the private map
//  static var metadataLookup: [ModifierKeys.Options: Metadata] {
//    // Convert the private `[ModifierKeys : Metadata]` into an `[Options : Metadata]` by taking any single-option key
//    var result: [ModifierKeys.Options: Metadata] = [:]
//    for (keySet, meta) in metadata {
//      // Find the single option contained in this key set
//      let singleOptions = ModifierKeys.Options.allCases.filter { keySet.contains($0) }
//      if singleOptions.count == 1, let single = singleOptions.first {
//        result[single] = meta
//      }
//    }
//    return result
//  }
//}
//
//extension ModifierKeys: CustomStringConvertible {
//  public var description: String {
//    displayName(elements: .name)
//  }
//}
