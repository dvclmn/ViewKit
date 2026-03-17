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
  public var dragRect: CGRect? = nil
  public var pointer: PointerState
  public var transform: TransformState

  public init(
    pointer: PointerState = .initial,
    transform: TransformState = .initial
  ) {
    self.pointer = pointer
    self.transform = transform
  }
}

extension CanvasInteractionState {
  func handleSwipeGesture(_ panEvent: PanEvent) {
    guard store.interaction == nil else { return }
    store.interaction = Interaction(
      kind: .scrolling(
        origin: .zero,
        delta: event.delta,
        location: event.location
      ),
      phase: event.phase,
      modifiers: modifierKeys
    )
    //        store.handlePan(delta: delta, phase: phase, state: &interactionState)
  }
  
  func handleHover(_ phase: HoverPhase) {
    
  }
}

extension CanvasInteractionState {

  public var translation: CGSize { transform.translation.value }
  public var scale: CGFloat { transform.scale.value }
  public var rotation: Angle { transform.rotation.value }

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
