//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreGraphics
import CoreTools
import Foundation

//struct PanState: GestureAction {
//  var value: CGSize = .zero
//  var kind: InteractionKind.Meta = .gesturePan
//
//  static let initial: Self = .init()
//}

public struct PanGestureStream {
  var translation: CGSize
  var phase: InteractionPhase

  public static var centered: Self { .init(.zero) }

  public init(
    _ translation: CGSize = .zero,
    phase: InteractionPhase = .none
  ) {
    self.translation = translation
    self.phase = phase
  }
}

extension PanGestureStream {
//  public mutating func update(_ other: Self) {
  public mutating func update(_ delta: CGSize, phase: InteractionPhase) {
    translation.width -= delta.width
    translation.height -= delta.height
    self.phase = phase
  }

  public func clamped(
    to geometry: CanvasGeometry,
    zoom: CGFloat
  ) -> CGSize {
    let artwork = geometry.canvasSize
    let viewport = geometry.viewportSize
    let scaledArtwork = artwork * zoom

    let maxX = max((scaledArtwork.width - viewport.width) / 2, 0)
    let maxY = max((scaledArtwork.height - viewport.height) / 2, 0)

    return CGSize(
      width: translation.width.clamped(to: -maxX...maxX),
      height: translation.height.clamped(to: -maxY...maxY)
    )

  }
}

//public struct PanState: Sendable {
//  public let value: CGSize
//
//  public static let initial: Self = .init()
//
//  public init( offset: CGSize = .zero) {
//    self.value = offset
//  }
//}
//extension PanState {
//
//  var offset: CGSize { value }

//  func clamped(
//    artwork: CGSize,
//    viewport: CGSize,
//    zoom: ZoomState
//  ) -> Self {
//    let scaledArtwork = artwork * zoom.zoom
//
//    let maxX = max((scaledArtwork.width - viewport.width) / 2, 0)
//    let maxY = max((scaledArtwork.height - viewport.height) / 2, 0)
//
//    return Self(
//      offset: CGSize(
//        width: offset.width.clamped(to: -maxX...maxX),
//        height: offset.height.clamped(to: -maxY...maxY)
//      )
//    )
//  }

/// ```
/// case .zoom(let zoomState):
///   zoom = zoomState
///   if zoomState.phase == .ended {
///     pan = .centred
///   }
/// ```
//  static var centered: Self { .init(offset: .zero) }

/// ```
/// context.translateBy(
///   x: pan.viewOffset(zoom: zoom).width,
///   y: pan.viewOffset(zoom: zoom).height
/// )
///
/// ```

/// ```
/// pan = pan
///   .translated(by: state.offset)
///   .withPhase(state.phase)
///
/// ```

//  public func withPhase(_ newPhase: Interaction.Phase) -> Self {
//    Self(offset: offset, phase: newPhase)
//  }
//  mutating func update(phase: GesturePhase) {
//
//  }
//  mutating func translate(by delta: CGSize) {
//    offset.width -= delta.width
//    offset.height -= delta.height
//  }
//
//  mutating func updatePhase(to new: GesturePhase) {
//    phase = new
////    offset.width -= delta.width
////    offset.height -= delta.height
//  }
//}
