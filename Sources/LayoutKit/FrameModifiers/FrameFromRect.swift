//
//  FromFromRectModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 30/7/2025.
//

import SwiftUI

// MARK: - Frame modifiers
public struct FrameFromRectModifier: ViewModifier {

  let rect: CGRect?
  let alignment: Alignment

  public func body(content: Content) -> some View {
    content
      .frame(
        width: rect?.width,
        height: rect?.height,
        alignment: alignment
      )
      .position(
        x: rect?.midX ?? .zero,
        y: rect?.midY ?? .zero
      )
  }
}

// MARK: - View extensions
extension View {

  public func frameFromRect(
    _ rect: CGRect?,
    alignment: Alignment = .center
  ) -> some View {
    self.modifier(
      FrameFromRectModifier(
        rect: rect,
        alignment: alignment
      )
    )
  }

}
