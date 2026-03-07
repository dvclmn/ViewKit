//
//  CanvasState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/3/2026.
//

import SwiftUI

/// I need to move ownership of important data like hover and zoom
/// out of CanvasView, so it can be reached more easily (up and down
/// the View hirearchy). This type encapsulates this data
//public struct CanvasState: Sendable, Equatable {
//  public var transform: TransformState = .initial
//  public var pointer: PointerState = .initial
//}

//extension CanvasState {
//  public static let initial: Self = .init()
//}
//  #warning("Will bring these back soon")
////  public var panState: PanState
////  public var zoomState: ZoomState
////  public var rotationState: RotateState
//
//  public var zoomLevel: Double
//  public var panOffset: CGSize
//  public var rotation: Angle
//
//  /// Location in Canvas space
//  let pointerLocation: CGPoint?
//
//  public init(
//    zoomLevel: Double = 1.0,
//    panOffset: CGSize = .zero,
//    rotation: Angle = .zero,
//    pointerLocation: CGPoint? = nil
//  ) {
//    self.zoomLevel = zoomLevel
//    self.panOffset = panOffset
//    self.rotation = rotation
//    self.pointerLocation = pointerLocation
//  }
//
//  public static let initial = CanvasState()
//}
