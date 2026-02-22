//
//  ResizableView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import SwiftUI

struct ResizableView<Content: View>: View {
  
  @State private var currentLength: CGFloat
  @GestureState private var dragDelta: CGFloat = 0
  
  let edge: Edge
  let minLength: CGFloat
  let maxLength: CGFloat
  let content: Content
  
  init(
    edge: Edge,
    initialLength: CGFloat,
    minLength: CGFloat = 50,
    maxLength: CGFloat = .infinity,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.edge = edge
    self._currentLength = State(initialValue: initialLength)
    self.minLength = minLength
    self.maxLength = maxLength
    self.content = content()
  }

  var body: some View {
    DynamicStack(axis: edge.toAxis) {
      content
    }
  }
}
