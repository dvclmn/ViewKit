//
//  PointerDragPayload.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import Foundation

/// This is an improvement over the previous CGRect, which was
/// trying to wear too many hats
public enum PointerDragPayload: Sendable {
  /// For panning/continuous
  case delta(Size<ScreenSpace>, location: Point<ScreenSpace>)

  /// For marquee/select
  case rect(from: Point<ScreenSpace>, current: Point<ScreenSpace>)
}

extension PointerDragPayload {
  var boundingRect: CGRect? {
    switch self {
      case .rect(let from, let current): /* compute bounding box */
      case .delta(let size, _): /* possibly return CGRect(origin: .zero, size: size.cgSize) */
    }
  }
}
