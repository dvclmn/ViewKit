//
//  MarqueeDragGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import CoreTools
import SwiftUI

private enum DragIntent {
  case undecided
  case dragging
}

public typealias MarqueeDragOutput = (PointerInteraction, InteractionPhase) -> Void

public struct MarqueeDragModifier: ViewModifier {
  @Environment(\.shouldRenderDragRect) private var shouldRenderDragRect

  @State private var intent: DragIntent = .undecided
  @State private var dragOrigin: CGPoint?
  @State private var rectToRender: CGRect?

  let isEnabled: Bool
  let dragThreshold: CGFloat
  let didUpdateRect: MarqueeDragOutput

  public func body(content: Content) -> some View {
    content
      .gesture(dragGesture)
      .modifier(DrawMarqueeModifier(rect: rectIfNeeded))
  }
}

extension MarqueeDragModifier {
  /// The rect to be drawn on screen, if this option is set
  private var rectIfNeeded: CGRect? {
    shouldRenderDragRect ? rectToRender : nil
  }

  private var dragGesture: some Gesture {
    /// IMPORTANT: `minimumDistance` must be set to zero,
    /// to allow both Drag *and* Tap detection. These are
    /// disambiguated via `dragThreshold`
    DragGesture(minimumDistance: 0)

      .onChanged { value in

        if dragOrigin == nil {
          dragOrigin = value.startLocation

          /// Register a 'press'
          didUpdateRect(.tap(value.startLocation), .began)
        }

        guard let origin = dragOrigin else { return }

        let rect = value.toRect(from: origin, end: .predicted)
//        CGRect(
//          origin: origin,
//          size: CGSize(
//            width: value.location.x - origin.x,
//            height: value.location.y - origin.y
//          )
//        ).standardized

        let isDragPermitted = rect.size.diagonalLength >= dragThreshold

        if intent != .dragging && isDragPermitted {
          intent = .dragging
        }

        if intent == .dragging {
          rectToRender = rect
          didUpdateRect(.drag(rect), .changed)
        }
      }

      .onEnded { value in

        didUpdateRect(.none, .ended)

        rectToRender = nil
        intent = .undecided
        dragOrigin = nil
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
