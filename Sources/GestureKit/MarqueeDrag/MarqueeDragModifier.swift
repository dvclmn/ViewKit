//
//  MarqueeDragGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import CoreTools
import SwiftUI

public typealias MarqueeDragOutput = (PointerInteraction?) -> Void

public struct MarqueeDragModifier: ViewModifier {
  @Environment(\.shouldRenderDragRect) private var shouldRenderDragRect

  @State private var dragOrigin: CGPoint?
  @State private var rectToRender: CGRect?

  let isEnabled: Bool
  let dragThreshold: CGFloat
  let didUpdateRect: MarqueeDragOutput

  public func body(content: Content) -> some View {
    content
      .onTapGesture { location in
        didUpdateRect(.tap(location))
        //            interactionKind = .tap(location)
      }
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
    DragGesture(minimumDistance: dragThreshold)

      .onChanged { value in

        if dragOrigin == nil {
          dragOrigin = value.startLocation
        }
        guard let origin = dragOrigin else { return }
        let rect = value.toRect(from: origin, end: .standard)

        rectToRender = rect
        didUpdateRect(.drag(rect, .changed))
      }

      .onEnded { _ in
        didUpdateRect(nil)
        rectToRender = nil
        dragOrigin = nil
      }
  }
}

//extension View {
//  public func marqueeDrag(
//    isEnabled: Bool = true,
//    dragThreshold: CGFloat = 5,
//    didUpdateRect: @escaping MarqueeDragOutput = { _ in }
//  ) -> some View {
//    self.modifier(
//      MarqueeDragModifier(
//        isEnabled: isEnabled,
//        dragThreshold: dragThreshold,
//        didUpdateRect: didUpdateRect
//      )
//    )
//  }
//}
