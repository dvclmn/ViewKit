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

  @State private var dragState: DragState

  @Binding var offset: CGSize
  let behavior: DragBehavior
  let isEnabled: Bool
  let minimumDistance: CGFloat
  let didUpdateTap: TapUpdate
  //  let includeTapGesture: Bool

  init(
    behavior: DragBehavior,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate
    //    includeTapGesture: Bool = false
  ) {
    self.behavior = behavior
    self.isEnabled = isEnabled
    self.minimumDistance = minimumDistance
    //    self.includeTapGesture = includeTapGesture

    /// Initialize state based on behavior
    self._dragState = State(initialValue: .initial(for: behavior))
  }

  public func body(content: Content) -> some View {
    content
      .onTapGesture { location in

        onUpdate(.tap(location))
        //        }
      }
      .gesture(dragGesture, isEnabled: isEnabled)
    //      .drawMarqueeRect(rect: canvasHandler.pointerState.dragRect, isEnabled: true)

  }
}
extension UnifiedDragModifier {
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minimumDistance)
      .onChanged { value in
        dragState.handleDragChange(value, behavior: behavior)
      }
      .onEnded { _ in
        dragState.handleDragEnd(behavior: behavior)
        //        dragState.handleDragChange(<#T##value: DragGesture.Value##DragGesture.Value#>, behavior: <#T##DragBehavior#>)
        //        dragState.handleDragEnd(behavior: behavior)
      }
  }
}

extension View {
  public func tapDragGesture(
    
  ) -> some View {
        self.modifier(
          UnifiedDragModifier(
            behavior: .marquee(onUpdate: onUpdate),
            isEnabled: isEnabled,
            minimumDistance: minimumDistance,
            includeTapGesture: includeTap
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
