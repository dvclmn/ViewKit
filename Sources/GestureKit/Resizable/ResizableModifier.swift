//
//  ResizableModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

struct ResizableModifier: ViewModifier {

  //  @State private var translation: CGSize?
  let hitArea: Double = 30

  @Binding var height: CGFloat

  func body(content: Content) -> some View {
    content
      .overlay(alignment: .top) {
        Rectangle()
          .frame(height: hitArea)
          .offset(y: -(hitArea / 2))
      }
      .tapDragGesture(
        scalar: $height.toOptionalBinding,
        //        translation: $translation,
        //        behavior: .marquee(drawMarquee: true),
        axis: .horizontal,
        //        behavior: .continuous(axes: .all),
        isEnabled: true,
        //        minimumDistance: canvasHandler.pointerDrag.dragThreshold,
        //        didUpdateTap: { location in
        //          canvasHandler.pointerTap.value = location
        //        }
      )
      .debugTextOverlay("Overlay height: " + "\(height.displayString, default: "nil")")
    //      .task(id: translation) {
    //        guard let height = translation?.height else { return }
    //        self.height = height
    //      }
  }
}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
