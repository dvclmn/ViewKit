//
//  ResizableView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import LayoutKit
import SwiftUI

struct ResizableView<Content: View>: View {

  @State private var currentLength: CGFloat
  @State private var dragDelta: CGFloat = .zero

  let state: ResizeState
  let content: Content

  init(
    edge: Edge,
    initialLength: CGFloat,
    minLength: CGFloat,
    maxLength: CGFloat,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self._currentLength = State(initialValue: initialLength)
    self.state = ResizeState(edge: edge, minLength: minLength, maxLength: maxLength)
    self.content = content()
  }

  var body: some View {
    DynamicStack(
      alignedAxis: state.isVertical
        ? .vertical(state.edge.toAlignment.horizontal)
        : .horizontal(state.edge.toAlignment.vertical),
      spacing: .zero
    ) {
      content
        .frame(
          width: state.isVertical ? nil : displaySize,
          height: state.isVertical ? displaySize : nil,
          alignment: state.edge.toAlignment.toOpposing
        )
        .overlay(alignment: state.edge.toAlignment) {
          ResizeHandle()
            .gesture(
              ResizeGesture(
                dragDelta: dragDelta,
                currentLength: $currentLength,
                state: state
              ) { delta in
                self.dragDelta = delta
              }
            )
            .environment(\.layoutAxis, state.edge.toAxis)
        }
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: state.edge.toAlignment.toOpposing
    )

  }
}

extension ResizableView {
  private var displaySize: CGFloat {
    state.displaySize(currentLength: currentLength, dragDelta: dragDelta)
  }
}
