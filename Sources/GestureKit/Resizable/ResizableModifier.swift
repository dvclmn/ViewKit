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

  let edge: Edge
  let minLength: CGFloat
  let maxLength: CGFloat

  private let handleThickness: CGFloat = 16

  init(
    edge: Edge,
    initialLength: CGFloat,
    minLength: CGFloat = 50,
    maxLength: CGFloat = .infinity
  ) {
    self.edge = edge
    self._currentLength = State(initialValue: initialLength)
    self.minLength = minLength
    self.maxLength = maxLength
  }

  func body(content: Content) -> some View {
    content
      .frame(
        width: isVertical ? nil : displaySize,
        height: isVertical ? displaySize : nil
      )
      .overlay(alignment: edge.alignment) {
//        ResizeHandle()
//          .gesture(dragGesture)
      }
      
  }
}

// MARK: - Gesture Logic
extension ResizableEdgeModifier {

//  private var layoutAxis: Axis {
//    edge.to
//  }
  private var isVertical: Bool {
    edge == .top || edge == .bottom
  }

  // Invert drag for Top and Leading edges
  private var dragMultiplier: CGFloat {
    (edge == .top || edge == .leading) ? -1 : 1
  }

  private var displaySize: CGFloat {
    (currentLength + (dragDelta * dragMultiplier)).clamped(to: minLength...maxLength)
  }

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .updating($dragDelta) { value, state, _ in
        // Use height for top/bottom, width for leading/trailing
        state = isVertical ? value.translation.height : value.translation.width
      }
      .onEnded { value in
        let translation = isVertical ? value.translation.height : value.translation.width
        let proposed = currentLength + (translation * dragMultiplier)
        currentLength = proposed.clamped(to: minLength...maxLength)
      }
  }

  @ViewBuilder
  private func ResizeHandle() -> some View {
   
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
