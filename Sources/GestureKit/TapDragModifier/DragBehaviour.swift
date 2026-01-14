//
//  DragBehaviour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

public enum DragBehavior {
  /// Transient rectangle from drag origin to current point
  case marquee(onUpdate: (PointerInteraction?) -> Void)

  /// Accumulated offset that persists across drags
  case cumulative(
    offset: Binding<CGSize>,
    axes: GridAxis.Set = .all,
    onDragging: (Bool) -> Void = { _ in }
  )
}

