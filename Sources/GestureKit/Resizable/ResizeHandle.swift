//
//  ResizeHandle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import CoreTools
import SwiftUI

struct ResizeHandle: View {
  @Environment(\.layoutAxis) private var layoutAxis
  private let handleThickness: CGFloat = 16
  var body: some View {

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
    .pointerStyleCompatible(isVertical ? .rowResize)

    /// Change cursor based on direction
    //    .onHover { inside in
    //      if inside {
    //#if os(macOS)
    //        isVertical ? NSCursor.resizeUpDown.push() : NSCursor.resizeLeftRight.push()
    //#endif
    //      } else {
    //#if os(macOS)
    //        NSCursor.pop()
    //#endif
    //      }
  }

}

extension ResizeHandle {
  private var isVertical: Bool {
    layoutAxis?.isVertical ?? false
  }
}
