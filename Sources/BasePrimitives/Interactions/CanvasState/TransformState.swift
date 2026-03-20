//
//  CanvasTransformState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

/// What is able to adjust zoom?
///
/// - Pinch Gesture (Global) (see `onPinchGesture()` in `InteractionModifiers`)
/// - Vertical Swipe Gesture when holding Option (Global)
/// - Pointer Drag when Zoom tool Selected
public struct TransformState: Sendable, Equatable {
  public var translation: Size<ScreenSpace>
  public var scale: Double
  public var rotation: Angle
  //  public var translation: ContinuousInteraction<CGSize>
  //  public var scale: ContinuousInteraction<CGFloat>
  //  public var rotation: ContinuousInteraction<Angle>

  public init(
    translation: Size<ScreenSpace> = .zero,
    scale: Double = 1.0,
    rotation: Angle = .zero,
    //    translation: ContinuousInteraction<CGSize> = .init(.zero),
    //    scale: ContinuousInteraction<CGFloat> = .init(1.0),
    //    rotation: ContinuousInteraction<Angle> = .init(.zero),
  ) {
    self.translation = translation
    self.scale = scale
    self.rotation = rotation
  }

  public var latchedZoomFocusGlobal: CGPoint?
  public static let initial: Self = .init()
  public static var identity: Self { initial }
}

extension TransformState {

  public mutating func reset() {
    self = Self.identity
    //    translation = .zero
    //    scale = 1.0
    //    rotation = .zero
    //    pan = .init(.zero)
    //    zoom = .init(1.0)
    //    rotation = .init(.zero)
  }
}

// MARK: - Space Conversion

extension TransformState {

  /// Converts a point between screen space and canvas-local space.
  ///
  /// - Screen space has pan and zoom applied (i.e. what the user sees).
  /// - Canvas space is artwork-local: no pan offset, no zoom scaling.
  ///
  /// Example:
  /// ```swift
  /// let canvasPoint = transform.convert(
  ///   tapLocation,
  ///   from: .screen,
  ///   to: .canvas
  /// )
  /// ```
  //  public func convert(
  //    _ point: CGPoint,
  //    from source: TransformSpace,
  //    to destination: TransformSpace
  //  ) -> CGPoint {
  //    guard source != destination else { return point }
  //
  //    let pan = translation.value
  //    let zoom = scale.value
  //
  //    switch (source, destination) {
  //      case (.screen, .canvas):
  //        return CGPoint(
  //          x: (point.x - pan.width) / zoom,
  //          y: (point.y - pan.height) / zoom
  //        )
  //      case (.canvas, .screen):
  //        return CGPoint(
  //          x: point.x * zoom + pan.width,
  //          y: point.y * zoom + pan.height
  //        )
  //      default:
  //        return point
  //    }
  //  }
}

// MARK: -
