//
//  PanDragGesture.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

/// This modifier handles a Drag Gesture that keeps track of
/// how far it has been dragged, so the *drag distance accumulates*.
struct CumulativeDragGestureModifier: ViewModifier {

  @State private var tracker: CumulativeDragController
  @Binding var offset: CGSize
  let isEnabled: Bool
  let minDragDistance: CGFloat
  let isDragging: (Bool) -> Void

  init(
    offset: Binding<CGSize>,
    axes: GridAxis.Set = .all,
    isEnabled: Bool,
    minDragDistance: CGFloat,
    isDragging: @escaping (Bool) -> Void
  ) {
    self._offset = offset
    self._tracker = State(
      initialValue: CumulativeDragController(axes: axes, strategy: .external)
    )
    self.isEnabled = isEnabled
    self.minDragDistance = minDragDistance
    self.isDragging = isDragging
  }

  func body(content: Content) -> some View {
    content
      .gesture(dragGesture, isEnabled: isEnabled)
  }
}

extension CumulativeDragGestureModifier {
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minDragDistance)
      .onChanged { value in

        /// 1. Only anchor once at the very beginning of this specific drag
        if tracker.anchor == nil {
          tracker.begin(with: offset)
        }

        /// 2. Update the binding using the stable anchor
        offset = tracker.update(translation: value.translation)

        isDragging(true)
      }

      .onEnded { gestureValue in
        tracker.end()
        isDragging(false)
      }
  }
}

extension View {
  public func cumulativeDrag(
    _ offset: Binding<CGSize>,
    isEnabled: Bool = true,
    minDragDistance: CGFloat = 5,
    isDragging: @escaping (Bool) -> Void = { _ in }
  ) -> some View {
    self.modifier(
      CumulativeDragGestureModifier(
        offset: offset,
        isEnabled: isEnabled,
        minDragDistance: minDragDistance,
        isDragging: isDragging
      )
    )
  }
}
