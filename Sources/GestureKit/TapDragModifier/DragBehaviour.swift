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
  case marquee(onUpdate: MarqueeUpdate)

  /// Accumulated offset that persists across drags
  case cumulative(
    offset: Binding<CGSize>,
    axes: GridAxis.Set = .all,
    onDragging: (Bool) -> Void = { _ in }
  )
}

enum DragPhase {
  case idle
  case active
}

enum DragState {
  case marquee(MarqueePhase)
  case cumulative(CumulativePhase)
}

//enum DragState {
//  case marquee(MarqueeDragState)
//  case cumulative(CumulativeDragState)
//}

public typealias MarqueeUpdate = (PointerInteraction?) -> Void
enum MarqueePhase {
  case idle
  case dragging(origin: CGPoint)
}

enum CumulativePhase {
  case idle(controller: CumulativeDragController)
  case dragging(controller: CumulativeDragController)
}
