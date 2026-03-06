//
//  BundledFont+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import CoreText
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

extension BundledFont {

  public var bundledURL: URL? {
    let bundle = BasePrimitivesResources.bundle

    if let directMatch = bundle.url(
      forResource: resourceName,
      withExtension: resourceExtension
    ) {
      return directMatch
    }

    let candidates =
      resourceURLs(with: nil)
      + resourceURLs(with: "Fonts")
      + resourceURLs(with: "Resources/Fonts")

    return candidates.first(where: {
      $0.lastPathComponent == "\(resourceName).\(resourceExtension)"
    })
  }

  private func resourceURLs(with subdirectory: String?) -> [URL] {
    let bundle = BasePrimitivesResources.bundle
    return bundle.urls(forResourcesWithExtension: resourceExtension, subdirectory: subdirectory) ?? []
  }

}
