//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

public struct UnifiedDragModifier: ViewModifier {
  let behavior: DragBehavior
  let isEnabled: Bool
  let minimumDistance: CGFloat
  let includeTapGesture: Bool

  @State private var dragState: DragState

  init(
    behavior: DragBehavior,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    includeTapGesture: Bool = false
  ) {
    self.behavior = behavior
    self.isEnabled = isEnabled
    self.minimumDistance = minimumDistance
    self.includeTapGesture = includeTapGesture

    /// Initialize state based on behavior
    switch behavior {
      case .marquee:
        self._dragState = State(initialValue: .marquee(origin: nil))
        
      case .cumulative(_, let axes, _):
        self._dragState = State(
          initialValue: .cumulative(
            controller: CumulativeDragController(axes: axes, strategy: .external)
          )
        )
    }
  }

  public func body(content: Content) -> some View {
    content
      .onTapGesture { location in
        if includeTapGesture, case .marquee(let onUpdate) = behavior {
          onUpdate(.tap(location))
        }
      }
      .gesture(dragGesture, isEnabled: isEnabled)
      .modifier(DrawMarqueeModifier(rect: rectIfNeeded))
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
      }
  }
}

extension View {
  public func marqueeDrag(
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    includeTap: Bool = true,
    onUpdate: @escaping (PointerInteraction?) -> Void
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

  public func cumulativeDrag(
    _ offset: Binding<CGSize>,
    axes: GridAxis.Set = .all,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    onDragging: @escaping (Bool) -> Void = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        behavior: .cumulative(offset: offset, axes: axes, onDragging: onDragging),
        isEnabled: isEnabled,
        minimumDistance: minimumDistance
      )
    )
  }
}
