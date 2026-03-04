//
//  SquareFrameModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

struct SquareFrameModifier: ViewModifier {
  
  let length: CGFloat
  func body(content: Content) -> some View {
    content
      .frame(
        width: length,
        height: length,
//        alignment: dimensions.alignment
      )
  }
}
extension View {
  public func squareFrame(_ length: CGFloat) -> some View {
    self.modifier(SquareFrameModifier(length: length))
  }
}
