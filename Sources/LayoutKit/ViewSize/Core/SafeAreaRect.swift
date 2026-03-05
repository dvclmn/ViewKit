//
//  SizeAndSafeInsets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI

public struct SafeAreaRect: Equatable, Sendable {
//public struct SizeAndSafeInsets: Equatable, Sendable {
  let size: CGSize
  let safeInsets: EdgeInsets
  
  let frame: CGRect
//  let space: CoordinateSpace
}

extension SafeAreaRect {
  
//  var bounds: CGRect {
//    space.
//  }
  public var rect: CGRect {
    let width = size.width - (safeInsets.leading)
//    let width = size.width - (safeInsets.leading + safeInsets.trailing)
    let height = size.height - (safeInsets.top)
//    let height = size.height - (safeInsets.top + safeInsets.bottom)
    
    return CGRect(
      x: safeInsets.leading,
      y: safeInsets.top,
      width: width,
      height: height
    )
  }
}
