//
//  ResizableModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import CoreTools
import SwiftUI

struct ResizableEdgeModifier: ViewModifier {
  @State private var currentLength: CGFloat
  @GestureState private var dragDelta: CGFloat = 0

  //  let edge: Edge
  //  let minLength: CGFloat
  //  let maxLength: CGFloat

  let state: ResizeState

  init(
    edge: Edge,
    initialLength: CGFloat,
    minLength: CGFloat = 50,
    maxLength: CGFloat = .infinity
  ) {
    //    self.edge = edge
    self._currentLength = State(initialValue: initialLength)
    //    self.minLength = minLength
    //    self.maxLength = maxLength
    self.state = ResizeState(edge: edge, minLength: minLength, maxLength: maxLength)
  }

  func body(content: Content) -> some View {
    content
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: state.edge.toAlignment.toOpposing
      )
      .frame(
        width: isVertical ? nil : displaySize,
        height: isVertical ? displaySize : nil,
        alignment: state.edge.toAlignment.toOpposing
      )
      .overlay(alignment: state.edge.toAlignment) {
        ResizeHandle()
          .gesture(
            ResizeGesture(
              dragDelta: dragDelta,
              currentLength: $currentLength,
              state: state
            )
          )
          .environment(\.layoutAxis, state.edge.toAxis)
      }

  }
}

// MARK: - Gesture Logic
extension ResizableEdgeModifier {

  private var isVertical: Bool { state.isVertical }
  private var displaySize: CGFloat {
    state.displaySize(currentLength: currentLength, dragDelta: dragDelta)
  }

}

extension View {
  func resizableEdge(
    _ edge: Edge,
    initialLength: CGFloat,
    minLength: CGFloat = 100,
    maxLength: CGFloat = 600
  ) -> some View {
    modifier(
      ResizableEdgeModifier(
        edge: edge,
        initialLength: initialLength,
        minLength: minLength,
        maxLength: maxLength
      )
    )
  }
}
