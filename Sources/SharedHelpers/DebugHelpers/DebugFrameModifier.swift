//
//  DebugFrameModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/6/2025.
//

#if DEBUG

import SwiftUI

public struct DebugFrameModifier: ViewModifier {

  let label: String
  let colour: Color

  public func body(content: Content) -> some View {
    content
      .border(colour.opacity(0.2), width: 2)
      .overlay(alignment: .topLeading) {
        Text(label)
          .font(.callout)
          .foregroundStyle(colour.opacity(0.8))
          .background(Color.black.opacity(0.8))
          .padding(Styles.sizeSmall)
      }
  }
}
extension View {
  public func debugFrame(_ text: String, _ colour: Color) -> some View {
    self.modifier(DebugFrameModifier(label: text, colour: colour))
  }
}
#endif
