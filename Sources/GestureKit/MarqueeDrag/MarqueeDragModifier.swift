//
//  MarqueeDragGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import CoreTools
import SwiftUI

public typealias MarqueeDragOutput = (CGRect?, InteractionPhase) -> Void
//public typealias MarqueeDragOutput = (PointerState) -> Void

public struct MarqueeDragModifier: ViewModifier {
  @Environment(\.shouldRenderDragRect) private var shouldRenderDragRect
  @GestureState private var tapOrDragState: CGRect?
  //  @GestureState private var tapOrDragState: CGPoint?
  @State private var rectToRender: CGRect?

  let isEnabled: Bool
  let dragThreshold: CGFloat
  let didUpdateRect: MarqueeDragOutput

  public func body(content: Content) -> some View {
    content
      .gesture(tapOrDragGesture)
      .modifier(DrawMarqueeModifier(rect: rectIfNeeded))
  }
}

extension MarqueeDragModifier {
  /// The rect to be drawn on screen, if this option is set
  private var rectIfNeeded: CGRect? {
    shouldRenderDragRect ? rectToRender : nil
  }

  private var tapOrDragGesture: some Gesture {
    ExclusiveGesture(tapGesture, dragGesture)
      .updating($tapOrDragState) { value, state, _ in
        print("`tapOrDragGesture`: Value\n\(value), State (CGRect): \(state?.displayString, default: "nil")")
      }
      .onEnded { value in
        print("The Exclusive gesture ended: \(value)")
      }
      
  }

  private var tapGesture: some Gesture {
    TapGesture()
      .onEnded { value in
        print("The *Tap* gesture of the TorD Gesture ended: \(value)")
      }
  }

  private var dragGesture: some Gesture {
    /// IMPORTANT: `minimumDistance` must be set to zero,
    /// to allow both Drag *and* Tap detection. These are
    /// disambiguated via `dragThreshold`
    DragGesture(minimumDistance: dragThreshold)

      .onChanged { value in
        let newRect = value.toRect(usingPredicated: true)
        rectToRender = newRect
        didUpdateRect(newRect, .changed)

      }
      .onEnded { gestureValue in
        didUpdateRect(nil, .ended)
        rectToRender = nil
      }
  }
}

extension View {
  public func marqueeDrag(
    isEnabled: Bool = true,
    dragThreshold: CGFloat = 5,
    didUpdateRect: @escaping MarqueeDragOutput = { _, _ in }
  ) -> some View {
    self.modifier(
      MarqueeDragModifier(
        isEnabled: isEnabled,
        dragThreshold: dragThreshold,
        didUpdateRect: didUpdateRect
      )
    )
  }
}
