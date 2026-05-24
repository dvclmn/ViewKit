//
//  DraggableModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/3/2025.
import CoreTools
import ViewTools
import LayoutKit
import SwiftUI

public struct BouncyDragModifier: ViewModifier {
  @State private var store: BouncyHandler

  public init(
    tension: CGFloat,
    isEnabled: Bool,
  ) {
    self._store = State(
      initialValue: BouncyHandler(
        tension: tension,
        isEnabled: isEnabled,
      )
    )
  }

  public func body(content: Content) -> some View {
    if #available(macOS 14.0, *) {
      content
        .viewSize(capture: .size, mode: .debounce(1)) { size in
          store.containerSize = size
        }
        .offset(store.dragOffset)
        .simultaneousGesture(gesture, isEnabled: store.isInputMethodEnabled(.clickAndDrag))
        .animation(
          .snappy(duration: 0.28, extraBounce: 0.45 * store.handleScale()),
          value: store.dragOffset
        )
    } else {
      content
    }
  }
}

extension BouncyDragModifier {
  var gesture: some Gesture {
    DragGesture(minimumDistance: 1)
      .onChanged { value in
        let offset = value.translation.applyTension(
          area: .widthAndHeight(store.containerSize),
          tension: store.tension,
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
    tension: CGFloat = 180,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      BouncyDragModifier(
        tension: tension,
        isEnabled: isEnabled
      )
    )
  }
}
