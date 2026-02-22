//
//  ResizableModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import CoreTools
import SwiftUI

// MARK: - Modifier

struct ResizableEdgeModifier: ViewModifier {

  /// The committed, persisted height — survives between drag sessions
  @State private var storedHeight: CGFloat

  /// The live delta for the current drag only — resets to zero after each gesture
  @State private var dragDelta: CGFloat = 0

  let minHeight: CGFloat
  let maxHeight: CGFloat

  init(initialHeight: CGFloat, minHeight: CGFloat, maxHeight: CGFloat) {
    _storedHeight = State(initialValue: initialHeight)
    self.minHeight = minHeight
    self.maxHeight = maxHeight
  }

  // The rendered height is always the sum of the two.
  // During a drag, dragDelta is live. At rest, it's zero.
  private var currentHeight: CGFloat {
    (storedHeight + dragDelta).clamped(to: minHeight...maxHeight)
  }

  func body(content: Content) -> some View {
    content
      .frame(height: currentHeight)
      .overlay(alignment: .bottom) {
        ResizeHandle(dragDelta: $dragDelta, storedHeight: $storedHeight)
      }
  }
}

// MARK: - Handle

// Kept as a separate View so its responsibilities are clear:
// it owns the gesture, nothing else.
private struct ResizeHandle: View {

  @Binding var dragDelta: CGFloat
  @Binding var storedHeight: CGFloat

  // How tall the hittable strip is. Visually it can be thinner.
  private let hitAreaHeight: CGFloat = 16

  var body: some View {
    ZStack {
      // The hittable region — invisible but fully interactive
      Color.clear
        .frame(height: hitAreaHeight)
        .contentShape(Rectangle())

      // A small visible affordance so the user knows it's draggable.
      // Swap this out for whatever suits your design.
      Capsule()
        .fill(Color.primary.opacity(0.2))
        .frame(width: 40, height: 4)
    }
    .gesture(
      DragGesture(minimumDistance: 4)
        .onChanged { value in
          // value.translation.height is cumulative from touch-down,
          // which is exactly what we want — no amplification risk.
          dragDelta = value.translation.height
        }
        .onEnded { value in
          // Commit the delta into storedHeight exactly once.
          // Then clear dragDelta so we start fresh next time.
          storedHeight += value.translation.height
          dragDelta = 0
        }
    )
  }
}

// MARK: - Clamp helper

extension Comparable {
  func clamped(to range: ClosedRange<Self>) -> Self {
    min(max(self, range.lowerBound), range.upperBound)
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
