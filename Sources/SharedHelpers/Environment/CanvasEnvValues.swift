//
//  CanvasEnvValues.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import SwiftUI

extension EnvironmentValues {

  /// This is primarily expected to represent the whole window of an app,
  /// minus any base UI components like Toolbar or Inspector.
  ///
  /// Useful as long as its companion modifier
  /// `viewportCapture(mode:showsIndicator:didUpdateSize)`
  /// is placed on the view the caller regards as the viewport area
  //  @Entry public var viewportSize: CGSize?
  @Entry public var viewportRect: CGRect?
  public var viewportSize: CGSize? {
    guard let viewportRect else { return nil }
    return viewportRect.size
  }

  /// From CanvasKit
  @Entry public var zoomLevel: Double = 1.0
  @Entry public var zoomRange: ClosedRange<Double>?
  
  @Entry public var panOffset: CGSize = .zero
  @Entry public var rotation: Angle = .zero
  
  @Entry public var hoverLocation: CGPoint?

  public var zoomClamped: Double {
    guard let zoomRange else { return zoomLevel }
    return zoomLevel.clamped(to: zoomRange)
  }

  /// Stabilises the existing Environment value for cornerRounding
  //  @Entry public var canvasRounding: Double?
  //  public func zoomAdjustedRounding(_ roundingOverride: Double? = nil) -> Double {
  //    guard let cornerRounding else { return nil }
  //    return cornerRounding.removingZoom(zoomLevel)
  //  }

  /// Aka artwork size, document size
  @Entry public var canvasSize: CGSize?

}
