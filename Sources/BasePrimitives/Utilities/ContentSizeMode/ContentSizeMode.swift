//
//  ResizeMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import EnumMacros
import InteractionKit
import SwiftUI

@MetaEnum
@CaseDetection
public enum ContentSizeMode {
  /// Fill destination rect exactly, even if aspect ratio is distorted
  case stretch

  /// Contain: scale uniformly to fit within destination (aspect ratio preserved)
  case fit

  /// Cover: scale uniformly to cover entire destination (aspect ratio preserved, may clip)
  case fill

  case fixed(CGFloat, axis: Axis)
}

extension ContentSizeMode {
  public func size(
    for containerSize: CGSize,
    aspectRatio: CGFloat,
    insets: EdgeInsets = .zero,
  ) -> CGSize {

    let sizeWithInsets: CGSize = containerSize.inset(by: insets)
    switch self {
      case .fit:
        // Scale uniformly to fit within container (preserve aspect ratio)
        // aspectRatio is defined as height/width
        let widthBased = CGSize(
          width: sizeWithInsets.width,
          height: sizeWithInsets.width * aspectRatio,
        )
        guard widthBased.height <= sizeWithInsets.height else {
          return CGSize(
            width: sizeWithInsets.height / aspectRatio,
            height: sizeWithInsets.height,
          )
        }
        return widthBased

      case .fill:
        // Scale uniformly to cover container (preserve aspect ratio, may clip)
        // Compare container ratio (h/w) to content aspectRatio (h/w)
        let containerRatio = sizeWithInsets.height / sizeWithInsets.width
        guard containerRatio > aspectRatio else {
          // Container is wider than content → match width
          return CGSize(
            width: sizeWithInsets.width,
            height: sizeWithInsets.width * aspectRatio,
          )
        }
        // Container is taller than content → match height
        return CGSize(
          width: sizeWithInsets.height / aspectRatio,
          height: sizeWithInsets.height,
        )

      case .stretch:
        // Fill the container exactly, ignoring aspect ratio
        return sizeWithInsets

      case .fixed(let length, let axis):
        // Fix one axis length, derive the other from aspectRatio (h/w)
        switch axis {
          case .horizontal:
            let width = length
            let height = length * aspectRatio
            return CGSize(width: width, height: height)
          case .vertical:
            let height = length
            let width = length / aspectRatio
            return CGSize(width: width, height: height)
        }
    }
  }
}
