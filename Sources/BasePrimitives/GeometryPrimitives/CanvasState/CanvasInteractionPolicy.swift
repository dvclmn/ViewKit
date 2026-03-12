//
//  CanvasInteractionPolicy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

public struct CanvasInteractionPolicy: Equatable, Sendable {
  public var panGestureEnabled: Bool
  public var zoomGestureEnabled: Bool
  public var dragBehaviour: DragBehavior
  
  /// Note: so far, hover seems to always be enabled.
  /// Maybe this will change, not sure.
  public var hoverEnabled: Bool

  public init(
    panGestureEnabled: Bool,
    zoomGestureEnabled: Bool,
    dragBehaviour: DragBehavior,
    hoverEnabled: Bool
  ) {
    self.panGestureEnabled = panGestureEnabled
    self.zoomGestureEnabled = zoomGestureEnabled
    self.dragBehaviour = dragBehaviour
    self.hoverEnabled = hoverEnabled
  }
}

extension CanvasInteractionPolicy {

  public static let `default` = Self(
    panGestureEnabled: true,
    zoomGestureEnabled: true,
    dragBehaviour: .none,
    hoverEnabled: true
  )
}
