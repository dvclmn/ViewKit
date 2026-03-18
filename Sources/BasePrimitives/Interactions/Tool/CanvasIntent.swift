//
//  CanvasIntent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

import Foundation

/// 1. Define what a Tool can actually output.
public enum CanvasIntent {
  case mutateTransform(TransformState)
  case updateHoverLocation(Point<ScreenSpace>)
  case updatePointerDrag(Rect<ScreenSpace>)  // E.g. marquee
  /// for tools that produce domain objects (drawing a shape, placing a point)
  //    case commitAction()
    case updatePointerStyle(PointerStyleCompatible)
  //  case updateSelection([(any CanvasElement).ID])
  //  case updateHoverStatus((any CanvasElement).ID?)
  case none
}

extension CanvasIntent {
  public static func defaultPan(
    delta: Size<ScreenSpace>,
    location: Point<ScreenSpace>,
    transform currentTransform: TransformState
  ) -> Self {
    var new = currentTransform
    new.translation += delta
    return .mutateTransform(new)
  }

  public static func defaultZoom(
    event: ZoomGestureEvent,
    transform currentTransform: TransformState
  ) -> Self {
    var new = currentTransform
    new.scale = event.magnification
    //    new.scale *= CGFloat(event.magnification)
    return .mutateTransform(new)
  }

}
