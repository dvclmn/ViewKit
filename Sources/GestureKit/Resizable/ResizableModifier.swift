//
//  ResizableModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import CoreTools
import SwiftUI

struct ResizableEdgeModifier: ViewModifier {

  @State private var storedHeight: CGFloat
  @GestureState private var dragDelta: CGFloat = 0

  let minHeight: CGFloat
  let maxHeight: CGFloat

  private let resizeSpace = "ResizableEdgeModifier.resizeSpace"

  init(initialHeight: CGFloat, minHeight: CGFloat, maxHeight: CGFloat) {
    _storedHeight = State(initialValue: initialHeight)
    self.minHeight = minHeight
    self.maxHeight = maxHeight
  }

  private var currentHeight: CGFloat {
    (storedHeight + dragDelta).clamped(to: minHeight...maxHeight)
  }

  func body(content: Content) -> some View {
    content
      .coordinateSpace(name: resizeSpace)
      .frame(height: currentHeight)
      .overlay(alignment: .bottom) {
        ResizeHandle()
          .gesture(dragGesture)
      }
  }

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: 2, coordinateSpace: .named(resizeSpace))
      .updating($dragDelta) { value, state, _ in
        state = value.translation.height
      }
      .onEnded { value in
        let proposed = storedHeight + value.translation.height
        storedHeight = proposed.clamped(to: minHeight...maxHeight)
      }
  }

  private struct ResizeHandle: View {
    private let hitAreaHeight: CGFloat = 16

    var body: some View {
      ZStack {
        Color.clear
          .frame(height: hitAreaHeight)
          .contentShape(Rectangle())

        Capsule()
          .fill(Color.primary.opacity(0.2))
          .frame(width: 40, height: 4)
      }
    }
  }
}

// MARK: - View extension

extension View {
  func resizableEdge(
    initialHeight: CGFloat,
    minHeight: CGFloat = 100,
    maxHeight: CGFloat = 600
  ) -> some View {
    modifier(
      ResizableEdgeModifier(
        initialHeight: initialHeight,
        minHeight: minHeight,
        maxHeight: maxHeight
      ))
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
