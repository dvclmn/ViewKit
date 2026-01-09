//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreGraphics
import Foundation
import SharedHelpers

public struct PanState: GestureStateProtocol, Sendable {
  public let value: CGSize
  public let phase: GesturePhase

  public static let initial: Self = .init()

  public init(
    offset: CGSize = .zero,
    phase: GesturePhase = .none
  ) {
    self.value = offset
    self.phase = phase
  }
}
extension PanState {

  var offset: CGSize { value }

  func clamped(
    artwork: CGSize,
    viewport: CGSize,
    zoom: ZoomState
  ) -> Self {
    let scaledArtwork = artwork * zoom.zoom

    let maxX = max((scaledArtwork.width - viewport.width) / 2, 0)
    let maxY = max((scaledArtwork.height - viewport.height) / 2, 0)

    return Self(
      offset: CGSize(
        width: offset.width.clamped(to: -maxX...maxX),
        height: offset.height.clamped(to: -maxY...maxY)
      ),
      phase: phase
    )
  }

  /// ```
  /// case .zoom(let zoomState):
  ///   zoom = zoomState
  ///   if zoomState.phase == .ended {
  ///     pan = .centred
  ///   }
  /// ```
  static var centered: Self { .init(offset: .zero, phase: .ended) }

  /// ```
  /// context.translateBy(
  ///   x: pan.viewOffset(zoom: zoom).width,
  ///   y: pan.viewOffset(zoom: zoom).height
  /// )
  ///
  /// ```
  func viewOffset(zoom: ZoomState) -> CGSize { offset * zoom.zoom }
  func artworkOffset(zoom: ZoomState) -> CGSize { offset / zoom.zoom }

  /// ```
  /// pan = pan
  ///   .translated(by: state.offset)
  ///   .withPhase(state.phase)
  ///
  /// ```
  func translated(by delta: CGSize) -> Self {
    Self(
      offset: CGSize(
        width: offset.width - delta.width,
        height: offset.height - delta.height
      ),
      phase: phase
    )
  }

  public func withPhase(_ newPhase: GesturePhase) -> Self {
    Self(offset: offset, phase: newPhase)
  }
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
}
