//
//  CanvasPolicy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

public struct CanvasPolicy: Equatable, Sendable {
  public var panGestureEnabled: Bool = true
  public var zoomGestureEnabled: Bool = true
  public var dragBehaviour: DragBehavior = .continuous()
  public var hoverEnabled: Bool = true

  public static let standard = CanvasPolicy()
  public static let lockScale = CanvasPolicy(zoomGestureEnabled: false)
}

extension CanvasPolicy: CustomStringConvertible {
  public var description: String {
    """
    CanvasPolicy
      - panGestureEnabled: \(panGestureEnabled)
      - zoomGestureEnabled: \(zoomGestureEnabled)
      - dragBehaviour: \(dragBehaviour.name)
      - hoverEnabled: \(hoverEnabled)
    """
  }
  
  public var descriptionSingleLine: String {
    """
    Modifiers Enabled [pan: \(panGestureEnabled), zoom: \(zoomGestureEnabled), tapDrag: \(dragBehaviour.name), hover: \(hoverEnabled)]

    """
  }
}

extension CanvasPolicy {
  /// Derives the appropriate input policy from the current canvas operation.
  public init(fromOperation operation: CanvasOperation) {
    switch operation {

      case .idle, .hovering:
        self = .standard

      case .panning:
        /// During a pointer-driven pan, gestures remain available so the user
        /// can switch mid-drag (e.g. pinch to zoom while panning).
        self = CanvasPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          dragBehaviour: .continuous(),
          hoverEnabled: false
        )

      case .zooming:
        self = CanvasPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          dragBehaviour: .none,
          hoverEnabled: false
        )

      case .selecting:
        self = CanvasPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          dragBehaviour: .marquee,
          hoverEnabled: false
        )

      case .placingText:
        self = CanvasPolicy(
          panGestureEnabled: false,
          zoomGestureEnabled: false,
          dragBehaviour: .marquee,
          hoverEnabled: false
        )
    }
  }
}
