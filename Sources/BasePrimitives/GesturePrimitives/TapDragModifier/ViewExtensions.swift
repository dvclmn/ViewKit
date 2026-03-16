//
//  ViewExtensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

extension View {

  /// Adds a unified tap and drag gesture, producing a `CGRect?` binding.
  ///
  /// The rect encodes different values depending on ``DragBehavior``:
  /// - **Marquee**: the selection rect from drag origin to current pointer.
  /// - **Continuous**: the accumulated pan offset in `size`; `origin` is always `.zero`.
  ///
  /// - Parameters:
  ///   - rect: Binding updated throughout the gesture lifecycle.
  ///   - behavior: Controls whether dragging produces a marquee rect or a pan offset.
  ///   - tapCount: Number of taps required to fire `didUpdateTap` (default `1`).
  ///   - minimumDistance: Minimum drag distance before the gesture activates (default `5` pt).
  ///   - didUpdateTap: Called with the tap location in the view's coordinate space.
  public func tapDragGesture(
    rect: Binding<CGRect?>,
    coordinateSpace: CoordinateSpace = .local,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool = true,
    //    tapCount: Int = 1,
    minimumDistance: CGFloat = 5,
    //    didUpdateTap: @escaping TapUpdate = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: rect,
        coordinateSpace: coordinateSpace,
        behaviour: behaviour,
        drawsMarqueeRect: drawsMarqueeRect,
        //        tapCount: tapCount,
        minimumDistance: minimumDistance,
        //        didUpdateTap: didUpdateTap
      )
    )
  }

  /// Adds a unified tap and drag gesture, producing a `CGSize?` translation binding.
  ///
  /// A convenience wrapper over ``tapDragGesture(rect:behavior:tapCount:minimumDistance:didUpdateTap:)``
  /// that projects the `size` component of the rect for callers that think in terms of offsets.
  public func tapDragGesture(
    translation: Binding<CGSize?>,
    coordinateSpace: CoordinateSpace = .local,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool = true,
    //    tapCount: Int = 1,
    minimumDistance: CGFloat = 5,
    //    didUpdateTap: @escaping TapUpdate = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: translation.toBindingRect,
        coordinateSpace: coordinateSpace,
        behaviour: behaviour,
        drawsMarqueeRect: drawsMarqueeRect,
        //        tapCount: tapCount,
        minimumDistance: minimumDistance,
        //        didUpdateTap: didUpdateTap
      )
    )
  }

  /// Adds a unified tap and drag gesture, projecting drag onto a single scalar axis.
  ///
  /// Useful for one-dimensional controls (sliders, knobs) that only care about
  /// movement along a single axis.
  ///
  /// - Parameters:
  ///   - scalar: Binding that receives the scalar offset along `axis`.
  ///   - axis: The axis to project onto.
  ///   - reversed: When `true`, inverts the sign of the delta (useful for vertical sliders).
  public func tapDragGesture(
    scalar: Binding<CGFloat?>,
    coordinateSpace: CoordinateSpace = .local,
    axis: GridAxis,
    reversed: Bool = false,
    tapCount: Int = 1,
    minimumDistance: CGFloat = 5,
    //    didUpdateTap: @escaping TapUpdate = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: scalar.toBindingRect(along: axis, reversed: reversed),
        coordinateSpace: coordinateSpace,
        behaviour: .continuous(axes: axis.toSet),
        drawsMarqueeRect: false,
        //        tapCount: tapCount,
        minimumDistance: minimumDistance,
        //        didUpdateTap: didUpdateTap
      )
    )
  }
}
