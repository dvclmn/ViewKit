//
//  PanDragGesture.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import SwiftUI

/// This modifier handles a Drag Gesture that keeps track of
/// how far it has been dragged, so the *drag distance accumulates*.
struct CumulativeDragGestureModifier: ViewModifier {

//  @State private var tracker = CumulativeDragTracker(axisMode: .both)
  @State private var tracker = CumulativeDragController(axes: .all, strategy: .external)
  @Binding var offset: CGSize
  let isEnabled: Bool
  let minDragDistance: CGFloat
  let isDragging: (Bool) -> Void

  func body(content: Content) -> some View {
    content
      .gesture(dragGesture, isEnabled: isEnabled)
        
//        CumulativeDragGesture(
//          tracker: $tracker,
//          offset: $offset,
//          minDragDistance: minDragDistance,
//          isDragging: isDragging
//        )
//      )
  }
}

extension CumulativeDragGestureModifier {
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minDragDistance)
    .onChanged { gestureValue in
      
      tracker.begin(with: offset)
      
//      tracker.beginIfNeeded(latestValue: offset)
//      guard let newOffset = tracker.computeOffset(translation: gestureValue.translation) else { return }
//      offset = newOffset
//      isDragging(true)
    }
    
    .onEnded { gestureValue in
      tracker.end()
      isDragging(false)
    }
  }
}

/// Constrained to horizontal axis
struct CumulativeHorizontalDragGestureModifier: ViewModifier {
  @State private var tracker = CumulativeDragTracker(axisMode: .horizontal)
  @Binding var offset: CGFloat
  let isDragging: (Bool) -> Void

  func body(content: Content) -> some View {
    content
      .gesture(
        CumulativeDragGesture(
          tracker: $tracker,
          offset: Binding(
            get: { CGSize(width: offset, height: 0) },
            set: { offset = $0.width }
          ),
          minDragDistance: 0,
          isDragging: isDragging
        )
      )
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

  func cumulativeHorizontalDrag(
    _ offset: Binding<CGFloat>,
    isDragging: @escaping (Bool) -> Void = { _ in }
  ) -> some View {
    self.modifier(
      CumulativeHorizontalDragGestureModifier(
        offset: offset,
        isDragging: isDragging
      )
    )
  }
}
