//
//  ResizableModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

struct ResizableModifier: ViewModifier {

  @State private var translation: CGSize?

  func body(content: Content) -> some View {
    content
      .tapDragGesture(
        translation: $translation,
        //        behavior: .marquee(drawMarquee: true),
        behavior: .continuous(axes: .vertical),
        //        behavior: .continuous(axes: .all),
        isEnabled: true,
        //        minimumDistance: canvasHandler.pointerDrag.dragThreshold,
        //        didUpdateTap: { location in
        //          canvasHandler.pointerTap.value = location
        //        }
      )
  }
}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
