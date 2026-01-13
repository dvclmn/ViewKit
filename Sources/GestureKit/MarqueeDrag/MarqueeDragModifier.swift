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
  //  case tap
  case dragging
}

public typealias MarqueeDragOutput = (PointerInteraction, InteractionPhase) -> Void
//public typealias MarqueeDragOutput = (PointerState) -> Void

public struct MarqueeDragModifier: ViewModifier {
  @Environment(\.shouldRenderDragRect) private var shouldRenderDragRect
  //  @GestureState private var tapOrDragState: CGRect?
  //  @GestureState private var tapLocation: CGPoint?
  //  @State private var latestStartLocation: CGPoint?

  @State private var intent: DragIntent = .undecided
  @State private var dragOrigin: CGPoint?

  //  @State private var latestInteraction: PointerInteraction.Meta = .none
  @State private var rectToRender: CGRect?

  let isEnabled: Bool
  let dragThreshold: CGFloat
  let didUpdateRect: MarqueeDragOutput

  public func body(content: Content) -> some View {
    content
      .gesture(dragGesture)
      //      .gesture(tapOrDragGesture)
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
          didUpdateRect(.pressing(value.startLocation), .began)
        }

        guard let origin = dragOrigin else { return }

        let rect = CGRect(
          origin: origin,
          size: CGSize(
            width: value.location.x - origin.x,
            height: value.location.y - origin.y
          )
        ).standardized

        let isDragPermitted = rect.size.diagonalLength >= dragThreshold
        
        if intent != .dragging && isDragPermitted {
          intent = .dragging
        }
        
        if intent == .dragging {
          rectToRender = rect
          didUpdateRect(.drag(rect), .changed)
        }
        
//        guard intent != .dragging else {
//          rectToRender = rect
//          didUpdateRect(.drag(rect), .changed)
//          return
//        }
//
//        if rect.size.diagonalLength >= dragThreshold {
//          intent = .dragging
//          rectToRender = rect
//          didUpdateRect(.drag(rect), .changed)
//        }

        //        switch intent {
        //          case .undecided:
        //            if rect.size.diagonalLength >= dragThreshold {
        //              intent = .drag
        ////              latestInteraction = .drag
        //            } else {
        //              intent = .tap
        ////              latestInteraction = .tap
        //            }
        //
        //          case .tap:
        //            didUpdateRect(.tap(value.location), .changed)
        //            return
        //
        //          case .drag:
        //            rectToRender = rect
        //            didUpdateRect(.drag(rect), .changed)
        //        }

        //        let newRect = value.toRect(usingPredicated: true)
        //        let isDrag = newRect.size.diagonalLength >= dragThreshold
        //
        //        if isDrag {
        //          latestInteraction = .drag
        //          rectToRender = newRect
        //          didUpdateRect(.drag(newRect), .changed)
        //
        //        } else {
        //          latestInteraction = .tap
        //          rectToRender = nil
        //          didUpdateRect(.tap(value.location), .changed)
        //        }
      }
      .onEnded { value in

        didUpdateRect(.none, .ended)
        
//        if intent != .dragging {
          /// This is your completed tap signal
//          didUpdateRect(.tap(value.location), .ended)
//        }
        
        rectToRender = nil
        intent = .undecided
        dragOrigin = nil
        
//        if intent == .dragging {
//          didUpdateRect(.none, .ended)
//        } else {
//          didUpdateRect(.tap(value.location), .ended)
//        }
//
//        rectToRender = nil
//        intent = .undecided
//        dragOrigin = nil

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
