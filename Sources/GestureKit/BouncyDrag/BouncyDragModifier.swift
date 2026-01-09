//
//  DraggableModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/3/2025.
//


import LayoutKit
import SwiftUI
import SharedHelpers

//
public struct BouncyDragModifier: ViewModifier {
  @State private var store: BouncyHandler

  public init(
    tension: CGFloat,
    isEnabled: Bool,
  ) {
    self._store = State(
      initialValue: BouncyHandler(
        tension: tension,
        isEnabled: isEnabled
      )
    )
  }

  public func body(content: Content) -> some View {

    if #available(macOS 14.0, *) {
      content
      /// Generous debounce, high polling rate not required here
        .viewSize(mode: .debounce(1)) { size in
          store.containerSize = size
        }
      
      //      .offset(store.wigglingOffset)
        .offset(store.dragOffset)
      //      .scaleEffect(store.handleScale())
      
#if canImport(AppKit)
        .onPanGesture(isEnabled: store.isInputMethodEnabled(.twoFingerPan)) { phase in
//          handlePanGesture(phase)
        }
#endif
        .simultaneousGesture(gesture, isEnabled: store.isInputMethodEnabled(.clickAndDrag))
        .animation(
          .snappy(duration: 0.28, extraBounce: 0.45 * store.handleScale()),
          value: store.dragOffset
        )
    } else {
      content
      // Fallback on earlier versions
    }
    //      .animation(
    //        Styles.animationSpringQuick,
    //        value: store.complexOscillation
    //      )

  }
}

//
extension BouncyDragModifier {

#warning("Temporarily switched off")
//  private func handlePanGesture(_ phase: PanPhase) {
//    switch phase {
//      case .active(let delta):
//        store.inputMethod = .twoFingerPan
//        let deltaOffset = store.dragOffset + delta
//        let offset = deltaOffset.applyTension(
//          area: .widthAndHeight(store.containerSize),
//          tension: store.tension
//        )
//        store.dragOffset = offset
//
//      case .ended(_), .cancelled:
//        store.reset()
//
//      case .inactive: break
//    }
//  }

  var gesture: some Gesture {
    DragGesture(minimumDistance: 1)
      .onChanged { value in
        let offset = value.translation.applyTension(
          area: .widthAndHeight(store.containerSize),
          tension: store.tension
        )
        store.dragOffset = offset
      }
      .onEnded { _ in
        store.reset()
      }
  }

}


extension View {
  public func bouncyDrag(
    tension: CGFloat = 180,  // Higher = stiffer
    isEnabled: Bool = true,
    //    containerSize: CGSize? = nil
  ) -> some View {
    self.modifier(
      BouncyDragModifier(
        tension: tension,
        isEnabled: isEnabled,
        //        containerSize: containerSize
      )
    )
  }
}
