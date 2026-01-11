//
//  ResizeMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

public enum ContentSizeMode {
  /// Fill destination rect exactly, even if aspect ratio is distorted
  case stretch
  
  /// Contain: scale uniformly to fit within destination (aspect ratio preserved)
  case fit
  
  /// Cover: scale uniformly to cover entire destination (aspect ratio preserved, may clip)
  case fill
  
  case fixed(CGFloat, axis: Axis2D)
}

extension ContentSizeMode {
  public func size(
    for containerSize: CGSize,
    aspectRatio: CGFloat,
    insets: EdgeInsets
  ) -> CGSize {
    
    let sizeWithInsets: CGSize = containerSize.inset(by: insets)
//    let insetSize: CGSize = containerSize.inset(by: viewportEdgeInset)
    switch self {
      case .fit:
        let widthBased = CGSize(
          width: sizeWithInsets.width,
          height: sizeWithInsets.width * aspectRatio
        )
        
        guard widthBased.height <= containerSize.height else {
          return CGSize(
            width: sizeWithInsets.height / aspectRatio,
            height: sizeWithInsets.height
          )
        }
        return widthBased
        
      case .fill:
        let containerRatio = sizeWithInsets.height / sizeWithInsets.width
        guard containerRatio > aspectRatio else {
          /// Container is wider than trackpad → match width
          return CGSize(
            width: sizeWithInsets.width,
            height: sizeWithInsets.width * aspectRatio
          )
        }
        /// Container is taller than trackpad → match height
        return CGSize(
          width: sizeWithInsets.height / aspectRatio,
          height: sizeWithInsets.height
        )
        
      case .stretch:
        return sizeWithInsets
        
      case .fixed(let length, let axis):
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
