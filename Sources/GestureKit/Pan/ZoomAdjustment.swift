//
//  ZoomAdjustment.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import Foundation

public enum ZoomAdjustment {
  case initial  // 100% / no zoom
  case zoom(CGFloat)
  case fit
//  case fit(CanvasGeometry)
  case fill
//  case fill(CanvasGeometry)
}

extension ZoomAdjustment {

  /// ```
  /// state = adjustment
  ///   .resolve(current: state, artwork: artwork, viewport: viewport)
  ///   .clamped()
  ///   .withPhase(.active)
  ///
  ///   ```
  func resolve(
    current: ZoomState,
    artwork: CGSize,
    viewport: CGSize
  ) -> ZoomState {
    switch self {
      case .initial:
        return ZoomState.initial

      case .zoom(let level):
        return ZoomState(zoom: level, phase: .changed)

      case .fit:
        let values = Self.scaleValues(
          artwork: artwork,
          viewport: viewport
        )
        return ZoomState(zoom: min(values.0, values.1), phase: .ended)

      case .fill:
        let values = Self.scaleValues(
          artwork: artwork,
          viewport: viewport
        )
        return ZoomState(zoom: max(values.0, values.1), phase: .ended)

    }
  }

  public static func scaleValues(
    artwork: CGSize,
    viewport: CGSize,
    padding: CGFloat = 40
  ) -> (CGFloat, CGFloat) {
    /// Calculate available space after padding
    let viewportAvailable = viewport.adjustBoth { $0 - (padding * 2) }

    return (
      viewportAvailable.width / artwork.width,
      viewportAvailable.height / artwork.height
    )

    //    return min(
    //      viewportAvailable.width / artwork.width,
    //      viewportAvailable.height / artwork.height
    //    )

  }
}
