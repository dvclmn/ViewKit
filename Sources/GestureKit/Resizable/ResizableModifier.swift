//
//  ResizableModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import CoreTools
import SwiftUI

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
