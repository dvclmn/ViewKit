//
//  CanvasState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/3/2026.
//

import CoreGraphics
import SwiftUI

/// I need to move ownership of important data like hover and zoom
/// out of CanvasView, so it can be reached more easily (up and down
/// the View hirearchy). This type encapsulates this data
public struct CanvasState: Sendable, Equatable {

  var zoomLevel: Double
  var panOffset: CGSize
  var rotation: Angle

  /// Location in Canvas space
  let pointerLocation: CGPoint?

  public init(
    zoomLevel: Double = 1.0,
    panOffset: CGSize = .zero,
    rotation: Angle = .zero,
    pointerLocation: CGPoint? = nil
  ) {
    self.zoomLevel = zoomLevel
    self.panOffset = panOffset
    self.rotation = rotation
    self.pointerLocation = pointerLocation
  }

  public static let initial = CanvasState()
}
