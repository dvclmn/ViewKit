//
//  PointerDragPayload.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import Foundation

/// This is an improvement over the previous CGRect, which was
/// trying to wear too many hats
public enum PointerDragPayload: Sendable, Equatable {
  /// For panning/continuous
  case delta(Size<ScreenSpace>, location: Point<ScreenSpace>)

  /// For marquee/select
  case rect(from: Point<ScreenSpace>, current: Point<ScreenSpace>)
}


//extension PointerDragPayload {
//  init() {
//    
//  }
//}
extension PointerDragPayload {
  var boundingRect: Rect<ScreenSpace>? {
    switch self {
      case .delta: nil
      //        return nil
      case .rect(let from, let current):
        Rect<ScreenSpace>(from: from, to: current)
    //        return Rect<ScreenSpace>(fromRect: CGRect.boundingRect(from: from, to: current))
    //        return
    }
  }
}
