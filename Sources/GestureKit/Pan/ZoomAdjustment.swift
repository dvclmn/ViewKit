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
  case fill
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
        return ZoomState(zoom: 1.0, phase: .inactive)

      case .zoom(let delta):
        return ZoomState(
          zoom: current.zoom * delta,
          phase: .active
        )

      case .fit:
        return ZoomState(
          zoom: ZoomState.fitScale(
            artwork: artwork,
            viewport: viewport
          ),
          phase: .ended
        )

      case .fill:
        return ZoomState(
          zoom: ZoomState.fillScale(
            artwork: artwork,
            viewport: viewport
          ),
          phase: .ended
        )
    }
  }
}
