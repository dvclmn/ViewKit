//
//  ZoomOperation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import Foundation

public enum ZoomOperation: Sendable {
  case initial  // 100% / no zoom
  case zoom(CGFloat)
  case fit
//  case fit(CanvasGeometry)
  case fill
//  case fill(CanvasGeometry)
}

extension ZoomOperation {

  /// ```
  /// state = adjustment
  ///   .resolve(current: state, artwork: artwork, viewport: viewport)
  ///   .clamped()
  ///   .withPhase(.active)
  ///
  ///   ```
  public func resolve(
//    current zoom: CGFloat,
//    current: ZoomState,
    artwork: CGSize,
    viewport: CGSize
  ) -> CGFloat {
//  ) -> ZoomState {
    switch self {
      case .initial: return .zero
      case .zoom(let level): return level
//        return ZoomState(zoom: level, phase: .changed)

      case .fit:
        let values = Self.scaleValues(
          artwork: artwork,
          viewport: viewport
        )
        return min(values.0, values.1)
//        return ZoomState(zoom: min(values.0, values.1), phase: .ended)

      case .fill:
        let values = Self.scaleValues(
          artwork: artwork,
          viewport: viewport
        )
        return max(values.0, values.1)

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
