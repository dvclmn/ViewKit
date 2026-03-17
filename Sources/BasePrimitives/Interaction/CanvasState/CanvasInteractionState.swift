//
//  CanvasInteractionState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/3/2026.
//

import SwiftUI

/// Supported stored properties
/// - Pan offset
/// - Zoom scale
/// -

/// `CanvasInteractionState`'s state is owned outside of CanvasKit,
/// by the project *using* CanvasKit. E.g. in the case of DrawString,
/// this is owned by `BaseContainer` view.
//@MainActor
@Observable
public final class CanvasInteractionState {

  /// General Note: May need to evolve CanvasKit to interpret a 'semantic entity',
  /// such as Strokes for Paperbark, and Cells for DrawString, etc?
  //  public var dragRect: CGRect? = nil
  public var transform: TransformState = .identity
  public var pointer: PointerState
  //  public var phase: InteractionPhase = .none

  public var activeTool: any CanvasTool

  public init(  //    pointer: PointerState = .initial,
    //    transform: TransformState = .identity
    )
  {
    //    self.pointer = pointer
    //    self.transform = transform
  }
}

extension CanvasInteractionState {

  public func handleInput(
    from source: InteractionSource,
    in geometry: CanvasGeometry,
    phase: InteractionPhase,
    modifiers: Modifiers,
  ) {
    
    let interaction = Interaction(
      source: source,
      geometry: geometry,
      phase: phase,
      modifiers: modifiers,
    )
    /// Route the input to the active tool
    let intent = activeTool.resolve(
      interaction: interaction,
      currentTransform: transform
    )

    /// Execute the tool's intent
    switch intent {
      case .mutateTransform(let newState):
        self.transform = newState

      case .updateHoverLocation(let point):
        self.pointer.hover = point

      case .none:
        break
    }
  }

  /// This has to be told where to put the value. It's just a swipe,
  /// doesn't know anything else
//  package func handleSwipeGesture(
//    //    _ interaction: Interaction
//    _ event: SwipeEvent,
//    //    phase: InteractionPhase,
//    //    modifiers: Modifiers
//    //    with interaction: Interaction
//  ) {
//    let interaction = Interaction(
//      kind: .swiping(delta: event.delta, location: event.location),
//      phase: event.phase,
//      modifiers: event.modifiers
//    )
//    handleInput(interaction)
//
//    //    self.phase = phase
//
//    //    guard store.interaction == nil else { return }
//    //    store.interaction = Interaction(
//    //      kind: .scrolling(
//    //        origin: .zero,
//    //        delta: event.delta,
//    //        location: event.location
//    //      ),
//    //      phase: event.phase,
//    //      modifiers: modifierKeys
//    //    )
//    //        store.handlePan(delta: delta, phase: phase, state: &interactionState)
//  }

//  package func handleHover(_ phase: HoverPhase) {
//
//  }

  public var snapshot: CanvasSnapshot {
    let hoverMapped =
    .init(
      pointer: <#T##Point<CanvasSpace>?#>,
      isPointerInsideCanvas: <#T##Bool#>,
      zoom: <#T##CGFloat#>,
      pan: <#T##CGSize#>,
      rotation: <#T##CGFloat#>
    )
  }

}

extension CanvasInteractionState {

  //  public var translation: CGSize { transform.translation.value }
  //  public var scale: CGFloat { transform.scale.value }
  //  public var rotation: Angle { transform.rotation.value }

  public func resetAll() {
    //    pointer.reset()
    dragRect = nil
    transform.reset()
  }
}

@MainActor
extension CanvasInteractionState {
  package func dragRectBinding(using policy: CanvasInputPolicy) -> Binding<CGRect?> {
    switch policy.dragBehaviour {
      case .marquee: handleMarquee()
      case .continuous: handleContinuous(using: policy)
      case .none: .constant(nil)
    }
  }

  private func handleContinuous(using policy: CanvasInputPolicy) -> Binding<CGRect?> {
    guard policy.pointerDragPanEnabled else {
      /// Continuous drag that isn't routed to pan (e.g. zoom tool vertical drag).
      /// Route to pointer drag state so the operation resolver can see it.
      return dragStateBinding()
    }
    return Binding {
      self.transform.translation.value.toCGRectZeroOrigin
      //      self.pan.toCGRectZeroOrigin
    } set: {
      guard let size = $0?.size else { return }
      self.transform.translation.update(size, phase: .changed)
      //      self.transform.pan.update(
      //        .init(fromCGSize: size),
      //        phase: .changed,
      //
      //      )
    }
  }

  private func handleMarquee() -> Binding<CGRect?> {
    dragStateBinding()
  }

  private func dragStateBinding() -> Binding<CGRect?> {
    Binding {
      self.pointer.drag.value?.cgRect
    } set: { newValue in
      self.pointer.drag.value = newValue.map {
        Rect<ScreenSpace>(from: $0)
      }
    }
  }

}
