//
//  Model+ResizePhase.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/8/2025.
//

import SwiftUI

//public typealias ResizeUpdate = (ResizePhase) -> Void
//
//public enum ResizePhase {
//  case changed(UnitPoint, CGSize)
//  case ended(UnitPoint, CGSize)
//}


/// I think this doesn't need to be cumulative. At the beginning
/// of any new Resize event, we get the current Canvas Size,
///
//struct ResizeDrag: Gesture {
//
////  @State private var localSizeAdjustment: CGSize = .zero
//  /// This should possibly be the temporary/local
//  /// size, adjusted freely, and then applied on gesture end?
//  @Binding var size: CGSize
//
//  let anchor: UnitPoint
//  let didEndResize: () -> Void
//
//  var body: some Gesture {
//    DragGesture(minimumDistance: 0)
//      .onChanged { value in
//
//        let newSize = resizedRect(
//          from: currentRect,
//          with: value.translation,
//          anchor: anchor
//        )
////        rect = newRect
//      }
//      .onEnded { value in
////        let newRect = resizedRect(
////          from: currentRect,
////          with: value.translation,
////          anchor: anchor
////        )
//        didEndResize()
//      }
//  }
//}
//extension ResizeDrag {
//
//  func resized(
//    //    from context: CanvasTransformContext?,
//    from initial: CGSize,
//    with translation: CGSize,
//    anchor: UnitPoint
//  ) -> CGRect {
//    //    guard let initial else { return .zero }
//
//    //    var newOrigin = initial.origin
//    //    var lastSize = initial.size
//
//    //    var newOrigin = context.canvasOriginInViewport
//    //    var newSize = context.zoomedCanvasSize
//
//    /// Adjust depending on which anchor is being dragged.
//    //    if anchor.x == 0 {  // left edge moves
//    //      newOrigin.x += translation.width
//    //      newSize.width -= translation.width
//    //    } else if anchor.x == 1 {  // right edge moves
//    //      newSize.width += translation.width
//    //    }
//    //
//    //    if anchor.y == 0 {  // top edge moves
//    //      newOrigin.y += translation.height
//    //      newSize.height -= translation.height
//    //    } else if anchor.y == 1 {  // bottom edge moves
//    //      newSize.height += translation.height
//    //    }
//
//    return CGRect(
//      origin: newOrigin,
//      size: newSize
//    ).standardized
//
//  }
//}
//  func resizedRect(
//    //    from context: CanvasTransformContext?,
//    from initial: CGRect?,
//    with translation: CGSize,
//    anchor: UnitPoint
//  ) -> CGRect {
//    guard let initial else { return .zero }
//
//    var newOrigin = initial.origin
//    var newSize = initial.size
//
//    //    var newOrigin = context.canvasOriginInViewport
//    //    var newSize = context.zoomedCanvasSize
//
//    /// Adjust depending on which anchor is being dragged.
//    if anchor.x == 0 {  // left edge moves
//      newOrigin.x += translation.width
//      newSize.width -= translation.width
//    } else if anchor.x == 1 {  // right edge moves
//      newSize.width += translation.width
//    }
//
//    if anchor.y == 0 {  // top edge moves
//      newOrigin.y += translation.height
//      newSize.height -= translation.height
//    } else if anchor.y == 1 {  // bottom edge moves
//      newSize.height += translation.height
//    }
//
//    return CGRect(
//      origin: newOrigin,
//      size: newSize
//    ).standardized
//
//  }

  //  func resizedRect(
  //    from context: CanvasTransformContext?,
  ////    from initial: CGRect?,
  //    with translation: CGSize,
  //    anchor: UnitPoint
  //  ) -> CanvasTransformContext? {
  //    guard let context else { return nil }
  //
  //    var newOrigin = context.canvasOriginInViewport
  //    var newSize = context.zoomedCanvasSize
  //
  //    /// Adjust depending on which anchor is being dragged.
  //    if anchor.x == 0 {  // left edge moves
  //      newOrigin.x += translation.width
  //      newSize.width -= translation.width
  //    } else if anchor.x == 1 {  // right edge moves
  //      newSize.width += translation.width
  //    }
  //
  //    if anchor.y == 0 {  // top edge moves
  //      newOrigin.y += translation.height
  //      newSize.height -= translation.height
  //    } else if anchor.y == 1 {  // bottom edge moves
  //      newSize.height += translation.height
  //    }
  //
  //
  ////    return CGRect(origin: newOrigin, size: newSize).standardized
  //
  //
  //  }
//}
