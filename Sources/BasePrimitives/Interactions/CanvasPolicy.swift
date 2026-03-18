//
//  CanvasInputPolicy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

/// Controls which input modifiers and gestures are active on the canvas.
///
/// Each tool declares its own `inputPolicy`, which is pushed into the
/// environment by `InteractionStateSetupModifier`. The policy gates
/// gesture modifiers in `InteractionModifiers`:
///
/// - `panGestureEnabled`: Two-finger trackpad pan gesture
/// - `pinchGestureEnabled`: Two-finger pinch-to-zoom gesture
/// - `pointerDragPanEnabled`: Whether a pointer click-drag can pan the canvas
///   (distinct from the two-finger gesture — this is for Pan tool drag)
/// - `dragBehaviour`: What kind of drag interaction the pointer produces
///   (marquee selection, continuous offset for pan/zoom, or disabled)
/// - `hoverEnabled`: Whether pointer hover tracking is active
public struct CanvasInputPolicy: Equatable, Sendable {

  /// Whether two-finger trackpad pan is active.
  public var panGestureEnabled: Bool

  /// Whether two-finger pinch-to-zoom is active.
  public var pinchGestureEnabled: Bool

  /// Whether pointer click-drag can pan the canvas.
  public var pointerDragPanEnabled: Bool

  /// The drag interaction mode: `.marquee`, `.continuous(axes:)`, or `.none`.
  public var dragBehaviour: DragBehavior

  /// Whether pointer hover position is tracked.
  public var hoverEnabled: Bool

  public init(
    panGestureEnabled: Bool = true,
    pinchGestureEnabled: Bool = true,
    pointerDragPanEnabled: Bool = false,
    dragBehaviour: DragBehavior = .none,
    hoverEnabled: Bool = true
  ) {
    self.panGestureEnabled = panGestureEnabled
    self.pinchGestureEnabled = pinchGestureEnabled
    self.pointerDragPanEnabled = pointerDragPanEnabled
    self.dragBehaviour = dragBehaviour
    self.hoverEnabled = hoverEnabled
  }

  /// Default idle policy: gestures enabled, no pointer-drag pan, hover on.
  public static let standard = CanvasInputPolicy()

  /// Locks zoom gesture only.
  public static let lockScale = CanvasInputPolicy(pinchGestureEnabled: false)
}

extension CanvasInputPolicy: CustomStringConvertible {
  public var description: String {
    """
    CanvasInputPolicy
      - panGestureEnabled: \(panGestureEnabled)
      - pinchGestureEnabled: \(pinchGestureEnabled)
      - pointerDragPanEnabled: \(pointerDragPanEnabled)
      - dragBehaviour: \(dragBehaviour.name)
      - hoverEnabled: \(hoverEnabled)
    """
  }

  public var descriptionSingleLine: String {
    "InputPolicy [pan: \(panGestureEnabled), zoom: \(pinchGestureEnabled), dragPan: \(pointerDragPanEnabled), tapDrag: \(dragBehaviour.name), hover: \(hoverEnabled)]"
  }
}
