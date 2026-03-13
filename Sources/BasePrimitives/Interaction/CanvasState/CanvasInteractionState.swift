//
//  CanvasInteractionState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/3/2026.
//

import SwiftUI

/// `CanvasInteractionState`'s state is owned outside of CanvasKit,
/// by the project *using* CanvasKit. E.g. in the case of DrawString,
/// this is owned by `BaseContainer` view.
@Observable
public final class CanvasInteractionState {
  public var pointer: PointerState
  public var transform: TransformState

  public init(
    pointer: PointerState = .initial,
    transform: TransformState = .initial
  ) {
    self.pointer = pointer
    self.transform = transform
  }
}

extension CanvasInteractionState {

  public var pan: CGSize { transform.pan.value }
  public var zoom: CGFloat { transform.zoom.value }
  public var rotation: Angle { transform.rotation.value }

  public func resetAll() {
    pointer.reset()
    transform.reset()
  }
}
