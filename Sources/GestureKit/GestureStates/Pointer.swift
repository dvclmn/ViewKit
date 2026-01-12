//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import Foundation

/// For handling Tap, Drag and Hover
public struct PointerTracking: Sendable {
  let start: CGPoint
  var current: CGPoint
  var phase: InteractionPhase

  let dragThreshold: CGFloat = 4
}

extension PointerTracking {
  var translation: CGSize {
    .init(
      width: current.x - start.x,
      height: current.y - start.y
    )
  }

  var isDrag: Bool {
    hypot(translation.width, translation.height) >= dragThreshold
  }

  var rect: CGRect {
    CGRect(
      origin: start,
      size: translation
    ).standardized
  }
}

//enum PointerInteraction {
//  case tap(CGPoint)
//  case drag(CGRect)
//  case hover(CGPoint)
//  case longPress(CGPoint)
//}
