//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

/// Goals for unified Tap/Drag modifier
/// - Send tap via callback
/// - Binding CGSize for offset
///
/// Previous separate modifiers
/// - Marquee sent drag back via callback, now Binding
/// - Cumulative used Binding for drag offset

public typealias DragUpdate = (Bool) -> Void
public typealias TapUpdate = (CGPoint) -> Void

public struct UnifiedDragModifier: ViewModifier {

  @State private var dragState: DragGestureState

  @Binding var dragRect: CGRect?
  let isEnabled: Bool
  let minimumDistance: CGFloat
  let didUpdateTap: TapUpdate

  init(
    rect: Binding<CGRect?>,
    behavior: DragBehavior,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate,
    //    didUpdateDrag: @escaping DragUpdate,

  ) {
    self._dragRect = rect
    //    self.behavior = behavior
    self.isEnabled = isEnabled
    self.minimumDistance = minimumDistance
    self.didUpdateTap = didUpdateTap
    //    self.isDragging = didUpdateDrag

    /// Initialize state based on behavior
    self._dragState = State(initialValue: DragGestureState(behavior))
  }

  public func body(content: Content) -> some View {
    content
      .onTapGesture { didUpdateTap($0) }
      .gesture(dragGesture, isEnabled: isEnabled)
      .drawMarqueeRect(rect: dragRect, isEnabled: behaviour.isMarquee)
//      .onAppear {
//        print("`UnifiedDragModifier` appeared. Drag rect value: \(dragRect?.render(using: .short), default: "nil")")
//      }

  }
}
extension UnifiedDragModifier {
  private var behaviour: DragBehavior { dragState.behaviour }

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minimumDistance)
      .onChanged { value in

        /// 1. Only anchor once at the very beginning of this specific drag
        if dragState.anchor == nil {
          dragState.begin(
            /// IMPORTANT: Not sure if I should use `dragRect.origin`,
            /// or the *size* (and convert to CGPoint)
            with: behaviour.isMarquee ? value.startLocation : dragRect?.size.toCGPoint
          )
        }

        /// Marquee approach:
        //        guard let origin = dragOrigin else { return }
        //        let rect = value.toRect(from: origin, end: .standard)
        //
        //        rectToRender = rect
        //        didUpdateRect(.drag(rect, .changed))
        //        dragState.handleDragChange(value, behavior: behavior)

        /// Accrue approach
        /// 2. Update the binding using the stable anchor
        //        offset = dragState.update(value)
        dragRect = dragState.update(value)
        //        isDragging(true)
      }

      .onEnded { value in
        if behaviour.isMarquee {
          dragRect = nil
        }
        dragState.end()
        //        isDragging(true)
        // Marquee:
        //        didUpdateRect(nil)
        //        rectToRender = nil
        //        dragOrigin = nil

        // Acrue:
        //        tracker.end()
        //        isDragging(false)
      }

  }
}

extension View {
  public func tapDragGesture(
    rect: Binding<CGRect?>,
    behavior: DragBehavior,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in },
    //    didUpdateDrag: @escaping DragUpdate = { _ in },
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: rect,
        behavior: behavior,
        isEnabled: isEnabled,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap,
        //        didUpdateDrag: didUpdateDrag
      )
    )
  }
  //  public func marqueeDrag(
  //    isEnabled: Bool = true,
  //    minimumDistance: CGFloat = 5,
  //    includeTap: Bool = true,
  //    onUpdate: @escaping (PointerInteraction?) -> Void
  //  ) -> some View {
  //    self.modifier(
  //      UnifiedDragModifier(
  //        behavior: .marquee(onUpdate: onUpdate),
  //        isEnabled: isEnabled,
  //        minimumDistance: minimumDistance,
  //        includeTapGesture: includeTap
  //      )
  //    )
  //  }
  //
  //  public func cumulativeDrag(
  //    _ offset: Binding<CGSize>,
  //    axes: GridAxis.Set = .all,
  //    isEnabled: Bool = true,
  //    minimumDistance: CGFloat = 5,
  //    onDragging: @escaping (Bool) -> Void = { _ in }
  //  ) -> some View {
  //    self.modifier(
  //      UnifiedDragModifier(
  //        behavior: .cumulative(offset: offset, axes: axes, onDragging: onDragging),
  //        isEnabled: isEnabled,
  //        minimumDistance: minimumDistance
  //      )
  //    )
  //  }
}
