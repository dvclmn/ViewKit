//
//  CanvasInteractionState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/3/2026.
//

import SwiftUI

/// `CanvasInteractionState`'s state is owned outside of CanvasKit,
/// by the project *using* CanvasKit. E.g. in the case of DrawString,
/// this is owned by `BaseContainer` view.
@Observable
public final class CanvasInteractionState {

  public var transform: TransformState = .identity
  public var pointer: PointerState = .initial
  public var geometry: CanvasGeometry?
  public var zoomRange: ClosedRange<CGFloat>?
  //  public var modifiers: Modifiers = []

  /// Synced here via the Env
  public var activeTool: (any CanvasTool)?

  /// The most recent domain action produced by a tool resolution.
  /// Consuming apps can observe this to react to tool-specific events
  /// (e.g. "select at point", "commit stroke").
  public var lastToolAction: ToolAction = .none

  /// The most recent pointer interaction context.
  public var lastPointerPhase: InteractionPhase = .none
  public var lastPointerSource: InteractionSource?

  public init() {}
}

// MARK: - Input handling (two-tier resolution)

extension CanvasInteractionState {

  /// Entry point for all raw input events from gesture modifiers.
  ///
  /// **Tier 1 — Global gestures** (swipe, pinch, hover) are handled
  /// centrally here. Tools never see these events.
  ///
  /// **Tier 2 — Pointer interactions** (tap, drag) are forwarded to
  /// the active tool's `resolve()` method.
  public func handleInput(
    from source: InteractionSource,
    phase: InteractionPhase,
    modifiers: Modifiers
  ) {

    /// 1 – Global gestures
    handleGlobalInteraction(source, modifiers: modifiers)

    /// 2 – Tool-specific pointer interactions
    handlePointerInteraction(
      source: source,
      phase: phase,
      modifiers: modifiers
    )
  }

  private func execute(_ intent: CanvasIntent) {
    switch intent {
      case .mutateTransform(let transform): self.transform = transform
      case .updatePointerDrag(let rect): self.pointer.drag = rect
      case .updatePointerTap(let point): self.pointer.tap = point
      case .none: break
    }
  }

  private func handlePointerInteraction(
    source: InteractionSource,
    phase: InteractionPhase,
    modifiers: Modifiers
  ) {

    guard let geometry, let activeTool else {
      print(
        "Missing geometry: \(geometry.debugDescription), or activeTool: \(activeTool?.name, default: "nil")")
      return
    }

    lastPointerSource = source
    lastPointerPhase = phase

    let interaction = Interaction(
      source: source,
      geometry: geometry,
      phase: phase,
      modifiers: modifiers
    )

    let resolution = activeTool.resolvePointerInteraction(interaction, currentTransform: transform)

    execute(resolution.intent)
    self.lastToolAction = resolution.action
  }

  private func handleGlobalInteraction(
    _ source: InteractionSource,
    modifiers: Modifiers
  ) {

    switch source {
      case .swipeGesture(let delta, _):
        if modifiers.contains(.option) {
          // Option + swipe = zoom (macOS convention)
          let zoomDelta = 1.0 + (delta.cgSize.height / 200.0)
          var new = transform
          new.scale *= zoomDelta
          if let zoomRange {
            new.scale = new.scale.clamped(to: zoomRange)
          }
          self.transform = new
        } else {
          var new = transform
          new.translation += delta
          self.transform = new
        }
        return

      case .pinchGesture(let event):
        var new = transform
        new.scale = event.magnification
        if let zoomRange {
          new.scale = new.scale.clamped(to: zoomRange)
        }
        self.transform = new
        return

      case .continuousHover(let point):
        self.pointer.hover = point
        return

      case .pointerTapGesture, .pointerDragGesture:
        break  // Fall through to Tier 2
    }

  }
}

// MARK: - Snapshot

extension CanvasInteractionState {

  private var coordinateSpaceMapper: CoordinateSpaceMapper? {
    guard let geometry, let zoomRange else { return nil }
    return .init(
      geometry: geometry,
      transform: transform,
      zoomRange: zoomRange
    )
  }

  public var snapshot: CanvasSnapshot? {
    guard let hover = pointer.hover,
      let hoverMapped = coordinateSpaceMapper?.canvasPoint(from: hover),
      let isInside = coordinateSpaceMapper?.isInsideCanvas(hoverMapped)
    else { return nil }

    return CanvasSnapshot(
      pointerLocation: hoverMapped,
      isPointerInsideCanvas: isInside,
      zoom: transform.scale,
      pan: transform.translation.cgSize,
      rotation: transform.rotation
    )
  }
}

// MARK: - Pointer style resolution

extension CanvasInteractionState {
  public func pointerStyle(with modifiers: Modifiers) -> PointerStyleCompatible? {
    activeTool?.resolvePointerStyle(
      context: ToolPointerContext(
        modifiers: modifiers,
        pointerPhase: lastPointerPhase,
        pointerSource: lastPointerSource
      )
    )
  }
}
