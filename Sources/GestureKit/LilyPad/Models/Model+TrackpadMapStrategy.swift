//
//  Model+TrackpadMapStrategy.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import SwiftUI

extension CGSize {
//  public static let trackpad = CGSize(
//    width: 700,
//    height: 438
//  )
  
  public static let trackpadAspectRatio: CGFloat = 10.0 / 16.0
  public static var trackpadSize: CGSize {
    let width: CGFloat = 700
    let height: CGFloat = width * trackpadAspectRatio
    return CGSize(width: width, height: height)
  }
}

//public enum TrackpadMapStrategy {
//
//  /// Fit trackpad within container width and height.
//  /// Respects trackpad aspect ratio
//  case scaleToFit
//
//  /// Fill container with trackpad
//  /// Respects trackpad aspect ratio.
//  case scaleToFill
//
//  /// Ignore trackpad aspect ratio, stretch
//  /// to fill entirety of supplied container size
//  case stretch
//
//  case customFixed(CGFloat, axis: Axis)
//  //  case custom(CustomMapStrategy)
//
//  private var aspectRatio: CGFloat {
//    Self.trackpadAspectRatio
//  }
//
//  private var viewportEdgeInset: CGFloat { 16 }
//
//
//}
//
//extension TrackpadMapStrategy {
// 
//
//  //  public static generateSize
//}
