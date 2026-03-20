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
  public var zoomRange: ClosedRange<Double>?
  //  public var modifiers: Modifiers = []

  /// Synced here via the Env
  public var activeTool: (any CanvasTool)?

  /// The most recent domain action produced by a tool resolution.
  /// Consuming apps can observe this to react to tool-specific events
  /// (e.g. "select at point", "commit stroke").
  public var lastToolAction: ToolAction = .none

  /// The most recent interaction context.
  public var phase: InteractionPhase = .none
  public var source: InteractionSource?
  public var adjustment: CanvasAdjustment?

  public init() {}
}

// MARK: - Input handling (two-tier resolution)

extension CanvasInteractionState {

  /// Entry point for all raw input events from gesture modifiers.
  ///
  /// **Tier 1 — Global gestures** (swipe, pinch, hover) are handled
  /// centrally here, via `GlobalInteraction`. Tools never see these events.
  ///
  /// **Tier 2 — Pointer interactions** (tap, drag) are forwarded to
  /// the active tool's `resolve()` method.
  public func handleInput(
    _ source: InteractionSource,
    phase: InteractionPhase,
    modifiers: Modifiers
  ) {

    guard let zoomRange else { return }

    /// 1 – Global gestures, such as pinch to Zoom, swipe to Pan
    GlobalInteraction.handleGlobalInteraction(
      source,
      zoomRange: zoomRange,
      modifiers: modifiers,
      transform: &transform,
      pointer: &pointer
    )

    /// 2 – Tool-specific pointer interactions, like hover and tap
    handlePointerInteraction(
      source: source,
      phase: phase,
      modifiers: modifiers
    )
  }

  private func execute(_ adjustment: CanvasAdjustment) {
    switch adjustment {
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

    guard let activeTool else { return }

    self.source = source
    self.phase = phase

    let resolution = activeTool.resolvePointerInteraction(
      context: InteractionContext(
        source: source,
        phase: phase,
        modifiers: modifiers
      ),
      currentTransform: transform
    )

    execute(resolution.adjustment)
    self.lastToolAction = resolution.action
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

extension CanvasInteractionState {
  public func pointerStyle(with modifiers: Modifiers) -> PointerStyleCompatible? {
    activeTool?.resolvePointerStyle(
      context: InteractionContext(
        source: source,
        phase: phase,
        modifiers: modifiers,
      )
    )
  }
}
