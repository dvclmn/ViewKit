//
//  PanZoomModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct PanZoomModifier: ViewModifier {
  @State private var handler: GestureHandler = .init()
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        PanGestureView { state in
          handler.update(.pan(state))
        }
      }
      .simultaneousGesture(zoomGesture(), isEnabled: true)
    
  }
}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
