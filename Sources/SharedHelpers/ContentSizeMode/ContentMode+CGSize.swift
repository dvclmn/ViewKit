//
//  ContentMode+CGSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import Foundation

extension CGSize {
  public func aspectRatio(
    mode: ContentSizeMode,
    intoSize size: CGSize
  ) -> CGSize {
    if self == .zero {
      return self
    }
    let widthRatio = size.width / self.width
    let heightRatio = size.height / self.height
    
    /// Handle stretch mode separately since it doesn't preserve aspect ratio
    if mode == .stretch {
      return size
    }
    
    let ratio: CGFloat =
    switch mode {
      case .fit: min(widthRatio, heightRatio)
      case .fill: max(widthRatio, heightRatio)
      case .stretch: 1.0
    }
    
    return CGSize(
      width: self.width * ratio,
      height: self.height * ratio
    )
  }
}
