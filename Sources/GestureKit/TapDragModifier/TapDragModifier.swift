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
  @State private var rectToDraw: CGRect?

  @Binding var offset: CGSize
  let behavior: DragBehavior
  let isEnabled: Bool
  let minimumDistance: CGFloat
  let didUpdateTap: TapUpdate
  let didUpdateDrag: DragUpdate

  init(
    behavior: DragBehavior,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate,
    didUpdateDrag: @escaping DragUpdate,

  ) {
    self.behavior = behavior
    self.isEnabled = isEnabled
    self.minimumDistance = minimumDistance
    self.didUpdateTap = didUpdateTap
    self.didUpdateDrag = didUpdateDrag

    /// Initialize state based on behavior
    self._dragState = State(initialValue: .initial(for: behavior))
  }

  public func body(content: Content) -> some View {
    content
      .onTapGesture { didUpdateTap($0) }
      .gesture(dragGesture, isEnabled: isEnabled)
          .drawMarqueeRect(rect: rectToDraw, isEnabled: true)

  }
}
extension UnifiedDragModifier {
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minimumDistance)
      .onChanged { value in
        
//        if dragOrigin == nil {
//          dragOrigin = value.startLocation
//        }
//        guard let origin = dragOrigin else { return }
//        let rect = value.toRect(from: origin, end: .standard)
//        
//        rectToRender = rect
//        didUpdateRect(.drag(rect, .changed))
        //        dragState.handleDragChange(value, behavior: behavior)
      }
      .onEnded { _ in
        //        dragState.handleDragEnd(behavior: behavior)
        //        dragState.handleDragChange(<#T##value: DragGesture.Value##DragGesture.Value#>, behavior: <#T##DragBehavior#>)
        //        dragState.handleDragEnd(behavior: behavior)
      }
  }
}

extension View {
  public func tapDragGesture(
    behavior: DragBehavior,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in },
    didUpdateDrag: @escaping DragUpdate = { _ in },
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        behavior: behavior,
        isEnabled: isEnabled,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap,
        didUpdateDrag: didUpdateDrag
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
