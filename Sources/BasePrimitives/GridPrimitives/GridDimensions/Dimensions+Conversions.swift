//
//  Dimensions+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/3/2026.
//

import Foundation

extension GridDimensions {

  public func toScreenSize(using unitSize: CGSize) -> CGSize? {
    guard
      let width = width.toScreenLength(using: unitSize.width),
      let height = height.toScreenLength(using: unitSize.height)
    else { return nil }

    return CGSize(width: width, height: height)
  }
}
