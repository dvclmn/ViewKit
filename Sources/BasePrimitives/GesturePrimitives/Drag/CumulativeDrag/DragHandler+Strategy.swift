//
//  DragController+Strategy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import Foundation

extension CumulativeDragHandler {
  /// Strategy determining whether the controller owns its state or relies on an external source.
  enum Strategy {
    /// External source-of-truth mode.
    /// The controller accepts the current offset at drag start.
    case external
    /// Internal owned state mode.
    /// The controller owns the offset starting from the given initial value.
    case `internal`(initial: CGSize)
  }
}
