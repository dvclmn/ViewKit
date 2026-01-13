//
//  MarqueeGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/8/2025.
//

//import CoreTools
//import SwiftUI

//struct MarqueeDragGesture: Gesture {
//  //  @Binding var rect: CGRect?
//  let dragThreshold: CGFloat
//  let didUpdateRect: MarqueeDragOutput
//  //  let didUpdateRect: (InteractionKind) -> Void
//
//  var body: some Gesture {
//   
//    DragGesture(minimumDistance: 0)
//
//      .onChanged { value in
//
//        //        let newRect = value.toRect
//
//        /// I think this is just updating for the Marquee rect drawing
//        //        rect = newRect
//
//        //        let isDrag: Bool = value.translation.eitherDimensionIsGreaterThan(dragThreshold)
//
//        let stream = PointerState(
//          start: value.startLocation,
//          current: value.predictedEndLocation,
//          phase: .changed
//        )
//        didUpdateRect(stream)
//        //        if isDrag {
//        //          //          didUpdateRect(.drag(newRect), .changed)
//        //
//        //        } else {
//        //          let location = newRect.point(at: .bottomTrailing)
//        //          didUpdateRect(.tap(location), .changed)
//        //          //          didUpdateRect(.tap(location), .changed)
//        //          //          didUpdateRect(.tap(location: newRect.point(at: .bottomTrailing)))
//        //        }
//
//      }
//      .onEnded { gestureValue in
//        didUpdateRect(.initial)
//
//        /// Resetting this value ensures we can start from a *new*
//        /// last-recorded corner, for the next gesture.
//        ///
//        /// Failing to set this to `nil` would result in a stale value
//        //        rect = nil
//      }
//  }
//}
