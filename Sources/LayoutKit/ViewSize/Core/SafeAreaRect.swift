//
//  SizeAndSafeInsets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import SwiftUI

public struct SafeAreaRect: Equatable, Sendable {
  let size: CGSize
  let safeInsets: EdgeInsets
  let globalFrame: CGRect
}

extension SafeAreaRect {
  /// The portion of the view's frame in the global coordinate space that is inside the safe area.
  /// This is computed by offsetting the global frame by the leading/top safe area insets and
  /// reducing the size by the total horizontal and vertical insets. Width and height are clamped
  /// to be non-negative.
  public var rect: CGRect {
    let x = globalFrame.origin.x + safeInsets.leading
    let y = globalFrame.origin.y + safeInsets.top
    let width = max(0, size.width - (safeInsets.leading + safeInsets.trailing))
    let height = max(0, size.height - (safeInsets.top + safeInsets.bottom))
    let result = CGRect(x: x, y: y, width: width, height: height)

//    DebugString("Safe Area Rect") {
//      Indented {
//        Labeled("X", value: x)
//        Labeled("Y", value: y)
//        Labeled("Width", value: width)
//        Labeled("Height", value: height)
//      }
//    }

    return result
  }
}

//extension SafeAreaRect {
//
//  public var rect: CGRect {
//
//    let x
//
//    let width = size.width - (safeInsets.leading)
////    let width = size.width - (safeInsets.leading + safeInsets.trailing)
//    let height = size.height - (safeInsets.top)
////    let height = size.height - (safeInsets.top + safeInsets.bottom)
//
//    return CGRect(
//      x: safeInsets.leading,
//      y: safeInsets.top,
//      width: width,
//      height: height
//    )
//  }
//}
