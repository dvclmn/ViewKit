//
//  MidPoint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

@available(macOS 14.0, *)
public struct MidpointModifier: ViewModifier {

  @State private var viewSize: CGSize = .zero

  let colour: Color

  public func body(content: Content) -> some View {
    content
      .viewSize(mode: .debounce()) { viewSize = $0 }
      .overlay {
        Circle()
          .fill(colour.opacity(0.4))
          .frame(width: 10, height: 10)
          .position(viewSize.midpoint)
      }
  }
}

@available(macOS 14.0, *)
extension View {
  public func midpointIndicator(
    colour: Color = .cyan
  ) -> some View {
    self.modifier(MidpointModifier(colour: colour))
  }
}
