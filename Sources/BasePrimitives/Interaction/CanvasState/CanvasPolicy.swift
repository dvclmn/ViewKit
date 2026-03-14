//
//  CanvasInputPolicy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

/// Controls which input modifiers and gestures are active on the canvas.
///
/// Each field gates a specific gesture or modifier in `TransformationsModifier`:
/// - `panGestureEnabled`: Two-finger trackpad pan gesture
/// - `zoomGestureEnabled`: Two-finger pinch-to-zoom gesture
/// - `pointerDragPanEnabled`: Whether a pointer click-drag can pan the canvas
///   (distinct from the two-finger gesture — this is for Pan tool drag)
/// - `dragBehaviour`: What kind of drag interaction the pointer produces
///   (marquee selection, continuous offset for pan/zoom, or disabled)
/// - `hoverEnabled`: Whether pointer hover tracking is active
public struct CanvasInputPolicy: Equatable, Sendable {

  /// Whether two-finger trackpad pan is active.
  public var panGestureEnabled: Bool

  /// Whether two-finger pinch-to-zoom is active.
  public var zoomGestureEnabled: Bool

  /// Whether pointer click-drag can pan the canvas.
  /// Only `true` when the Pan tool (or a spring-loaded Pan) is the effective tool.
  public var pointerDragPanEnabled: Bool

  /// The drag interaction mode: `.marquee`, `.continuous(axes:)`, or `.none`.
  public var dragBehaviour: DragBehavior

  /// Whether pointer hover position is tracked.
  public var hoverEnabled: Bool

  public init(
    panGestureEnabled: Bool = true,
    zoomGestureEnabled: Bool = true,
    pointerDragPanEnabled: Bool = false,
    dragBehaviour: DragBehavior = .none,
    hoverEnabled: Bool = true
  ) {
    self.panGestureEnabled = panGestureEnabled
    self.zoomGestureEnabled = zoomGestureEnabled
    self.pointerDragPanEnabled = pointerDragPanEnabled
    self.dragBehaviour = dragBehaviour
    self.hoverEnabled = hoverEnabled
  }

  /// Default idle policy: gestures enabled, no pointer-drag pan, hover on.
  public static let standard = CanvasInputPolicy()

  /// Locks zoom gesture only.
  public static let lockScale = CanvasInputPolicy(zoomGestureEnabled: false)
}

extension CanvasInputPolicy {

  /// Derives the appropriate input policy from the current canvas operation
  /// and the effective tool.
  ///
  /// The `tool` parameter is used to derive sensible defaults when idle —
  /// for example, the Select tool's idle drag behaviour is `.marquee`,
  /// while the Pan tool's is `.continuous`.
  ///
  /// ## Extending for domain-specific operations
  ///
  /// 1. Add a `kind` constant:
  /// ```swift
  /// extension CanvasOperation.Kind {
  ///   public static let placingText = Self(rawValue: "placingText")
  /// }
  /// ```
  ///
  /// 2. Extend the policy switch:
  /// ```swift
  /// case .placingText:
  ///   self = CanvasInputPolicy(dragBehaviour: .none, hoverEnabled: false)
  /// ```
  public init(
    fromOperation operation: CanvasOperation,
    tool: CanvasTool
  ) {
    switch operation.kind {
      case .idle, .hovering:
        // Derive idle drag behaviour from the tool's declared preference.
        // This prevents e.g. the Select tool from allowing continuous-drag panning.
        self = CanvasInputPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          pointerDragPanEnabled: false,
          dragBehaviour: tool.dragBehavior,
          hoverEnabled: true
        )

      case .panning:
        // During a pointer-driven pan, gestures remain available so the user
        // can switch mid-drag (e.g. pinch to zoom while panning).
        self = CanvasInputPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          pointerDragPanEnabled: true,
          dragBehaviour: .continuous(),
          hoverEnabled: false
        )

      case .zooming:
        // Pointer-drag zoom uses vertical axis only.
        self = CanvasInputPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          pointerDragPanEnabled: false,
          dragBehaviour: .continuous(axes: .vertical),
          hoverEnabled: false
        )

      case .selecting:
        self = CanvasInputPolicy(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          pointerDragPanEnabled: false,
          dragBehaviour: .marquee,
          hoverEnabled: false
        )

      default:
        // Fallback for domain-specific kinds — use tool's drag preference.
        self = CanvasInputPolicy(
          dragBehaviour: tool.dragBehavior,
          hoverEnabled: true
        )
    }
  }
}

extension CanvasInputPolicy: CustomStringConvertible {
  public var description: String {
    """
    CanvasInputPolicy
      - panGestureEnabled: \(panGestureEnabled)
      - zoomGestureEnabled: \(zoomGestureEnabled)
      - pointerDragPanEnabled: \(pointerDragPanEnabled)
      - dragBehaviour: \(dragBehaviour.name)
      - hoverEnabled: \(hoverEnabled)
    """
  }

  public var descriptionSingleLine: String {
    "InputPolicy [pan: \(panGestureEnabled), zoom: \(zoomGestureEnabled), dragPan: \(pointerDragPanEnabled), tapDrag: \(dragBehaviour.name), hover: \(hoverEnabled)]"
  }
}
