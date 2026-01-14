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

  @State private var trackerOld = CumulativeDragTracker(axes: .all)
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
      initialValue: CumulativeDragController(axes: axes, strategy: .internal(initial: offset.wrappedValue))
    )
    self.isEnabled = isEnabled
    self.minDragDistance = minDragDistance
    self.isDragging = isDragging
  }

  func body(content: Content) -> some View {
    content
      .gesture(
        CumulativeDragGesture(
          tracker: $trackerOld,
          offset: $offset,
          minDragDistance: minDragDistance,
          isDragging: isDragging
        ),
        isEnabled: isEnabled
      )
//      .gesture(dragGesture, isEnabled: isEnabled)
  }
}

extension CumulativeDragGestureModifier {
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minDragDistance)
      .onChanged { value in

        tracker.begin(with: offset)
        offset = tracker.update(translation: value.translation)
        isDragging(true)
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
//struct CumulativeHorizontalDragGestureModifier: ViewModifier {
//  @State private var tracker = CumulativeDragTracker(axisMode: .horizontal)
//  @Binding var offset: CGFloat
//  let isDragging: (Bool) -> Void
//
//  func body(content: Content) -> some View {
//    content
//      .gesture(
//        CumulativeDragGesture(
//          tracker: $tracker,
//          offset: Binding(
//            get: { CGSize(width: offset, height: 0) },
//            set: { offset = $0.width }
//          ),
//          minDragDistance: 0,
//          isDragging: isDragging
//        )
//      )
//  }
//}

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

  //  func cumulativeHorizontalDrag(
  //    _ offset: Binding<CGFloat>,
  //    isDragging: @escaping (Bool) -> Void = { _ in }
  //  ) -> some View {
  //    self.modifier(
  //      CumulativeHorizontalDragGestureModifier(
  //        offset: offset,
  //        isDragging: isDragging
  //      )
  //    )
  //  }
}
