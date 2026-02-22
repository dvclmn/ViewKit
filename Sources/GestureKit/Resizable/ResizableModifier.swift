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
        ResizeHandle()
          .gesture(dragGesture)
      }
  }
}

// MARK: - Gesture Logic
extension ResizableEdgeModifier {

  /// Determine if we are resizing vertically or horizontally
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
    ZStack {
      Color.clear
        .contentShape(Rectangle())
        .frame(
          width: isVertical ? nil : handleThickness,
          height: isVertical ? handleThickness : nil
        )

      // The visual indicator (the "pill")
      Capsule()
        .fill(Color.secondary.opacity(0.5))
        .frame(
          width: isVertical ? 40 : 4,
          height: isVertical ? 4 : 40
        )
    }
    // Change cursor based on direction
    .onHover { inside in
      if inside {
        #if os(macOS)
        isVertical ? NSCursor.resizeUpDown.push() : NSCursor.resizeLeftRight.push()
        #endif
      } else {
        #if os(macOS)
        NSCursor.pop()
        #endif
      }
    }
  }
}

// MARK: - Helper Extension
extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    min(max(self, limits.lowerBound), limits.upperBound)
  }
}

//struct ResizableEdgeModifier: ViewModifier {
//
//  @State private var storedHeight: CGFloat
//  @GestureState private var dragDelta: CGFloat = 0
//
//  let edge: Edge
//  let minHeight: CGFloat
//  let maxHeight: CGFloat
//
//  private let hitAreaHeight: CGFloat = 16
//  private let resizeSpace = "ResizableEdgeModifier.resizeSpace"
//
//  init(
//    initialLength: CGFloat,
//    edge: Edge,
//    minHeight: CGFloat,
//    maxHeight: CGFloat
//  ) {
//    self._storedHeight = State(initialValue: initialLength)
//    self.edge = edge
//    self.minHeight = minHeight
//    self.maxHeight = maxHeight
//  }
//
//  func body(content: Content) -> some View {
//    content
//      .frame(height: currentHeight)
//
//      .overlay(alignment: edge.alignment) {
//        ResizeHandle()
//          .gesture(dragGesture)
//      }
//  }
//}
//
//extension ResizableEdgeModifier {
//
//  /// Determines if the drag movement should be inverted based on the edge.
//  private var dragMultiplier: CGFloat {
//    switch edge {
//      case .top, .leading:
//        return -1
//      case .bottom, .trailing:
//        return 1
//    }
//  }
//
//  private var currentHeight: CGFloat {
//    /// Apply the multiplier to the dragDelta
//    let adjustedDelta = dragDelta * dragMultiplier
//    return (storedHeight + adjustedDelta).clamped(to: minHeight...maxHeight)
//  }
//
//  private var dragGesture: some Gesture {
//    DragGesture(minimumDistance: 2, coordinateSpace: .global)
//      .updating($dragDelta) { value, state, _ in
//        state = value.translation.height
//      }
//      .onEnded { value in
//        // Apply the multiplier here as well to update the base state
//        let adjustedTranslation = value.translation.height * dragMultiplier
//        let proposed = storedHeight + adjustedTranslation
//        storedHeight = proposed.clamped(to: minHeight...maxHeight)
//      }
//  }
//
//  @ViewBuilder
//  private func ResizeHandle() -> some View {
//    ZStack(alignment: .center) {
//      Color.clear
//        .frame(height: hitAreaHeight)
//        .contentShape(Rectangle())
//
//      Capsule()
//        .fill(Color.primary.opacity(0.2))
//        .frame(width: 40, height: 4)
//    }
//  }
//}

// MARK: - View extension

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
      //      ResizableEdgeModifier(
      //        initialHeight: initialHeight,
      //        edge: edge,
      //        minHeight: minHeight,
      //        maxHeight: maxHeight
      //      )
    )
  }
}
//struct ResizableModifier: ViewModifier {
//
//  //  @State private var translation: CGSize?
//  let hitArea: Double = 30
//
//  @Binding var height: CGFloat
//
//  /// Note: the gesture axis will probably be perpendiculer
//  /// to this one, as the grabbable hit area is perp to the
//  /// user-dragging axis
//  let axis: GridAxis
//
//  func body(content: Content) -> some View {
//    content
//      .tapDragGesture(
//        scalar: $height.toOptionalBinding,
//        axis: axis,
//        reversed: true,
//        isEnabled: true,
//      )
//      .overlay(alignment: .bottom) {
//        Rectangle()
//          .fill(.cyan.tertiary)
//          .overlay {
//            Text("Height: \(height.displayString(places: 0))")
//          }
//          .frame(height: hitArea)
//          .offset(y: hitAreaOffset)
//        //          .position(CGPoint(.zero, height))
//      }
//    //      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//    //      .frame(height: height)
//
//    //      .border(Color.green.opacity(0.3))
//
//    //      .debugTextOverlay("Overlay height: " + "\(height.displayString, default: "nil")")
//
//  }
//}
//extension ResizableModifier {
//  private var hitAreaOffset: Double {
//    let h = height * -1
//    //    let hit = (hitArea / 2) * -1
//    return h
//  }
//}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
