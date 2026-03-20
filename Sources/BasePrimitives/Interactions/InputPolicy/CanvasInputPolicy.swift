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
/// - `swipeGestureEnabled`: Two-finger trackpad pan gesture
/// - `pinchGestureEnabled`: Two-finger pinch-to-zoom gesture
/// - `dragBehaviour`: What kind of drag interaction the pointer produces
///   (marquee selection, continuous offset for pan/zoom, or disabled)
/// - `hoverEnabled`: Whether pointer hover tracking is permitted
public struct CanvasInputPolicy: Equatable, Sendable {

//  public var activeInputs: ActiveInputs
  /// Whether two-finger trackpad pan is active.
  public var swipeGestureEnabled: Bool

  /// Whether two-finger pinch-to-zoom is active.
  public var pinchGestureEnabled: Bool

  /// Whether pointer click-drag can pan the canvas.
//  public var pointerDragPanEnabled: Bool

  /// The drag interaction mode: `.marquee`, `.continuous(axes:)`, or `.none`.
  public var dragBehaviour: DragBehavior

  /// Whether pointer hover position is tracked.
  public var hoverEnabled: Bool

  public init(
    swipeGestureEnabled: Bool = true,
    pinchGestureEnabled: Bool = true,
//    pointerDragPanEnabled: Bool = false,
    dragBehaviour: DragBehavior = .none,
    hoverEnabled: Bool = true
  ) {
    self.swipeGestureEnabled = swipeGestureEnabled
    self.pinchGestureEnabled = pinchGestureEnabled
//    self.pointerDragPanEnabled = pointerDragPanEnabled
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
    DisplayString {
      Indented("Canvas Input Policy") {
        Labeled("Swipe", value: swipeGestureEnabled)
        Labeled("Pinch", value: pinchGestureEnabled)
//        Labeled("Pointer drag pan", value: pointerDragPanEnabled)
        Labeled("Drag behaviour", value: dragBehaviour.name)
        Labeled("Hover", value: hoverEnabled)
      }
    }.text
  }

//  public var descriptionSingleLine: String {
//    "InputPolicy [pan: \(swipeGestureEnabled), zoom: \(pinchGestureEnabled), dragPan: \(pointerDragPanEnabled), tapDrag: \(dragBehaviour.name), hover: \(hoverEnabled)]"
//  }
}

