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
  let labelOpacity: CGFloat
  let colour: Color
  let isEnabled: Bool

  public func body(content: Content) -> some View {
    content
      .border(colour.opacity(isEnabled ? 0.2 : 0.0), width: 2)
      .overlay(alignment: .topLeading) {
        if isEnabled {
          Text(label)
            .font(.callout)
            .opacity(labelOpacity)
            .foregroundStyle(colour.opacity(0.8))
            .background(Color.black.opacity(0.8))
            .padding(Styles.sizeSmall)
        }
      }
  }
}
extension View {
  public func debugFrame(
    _ text: String,
    _ colour: Color,
    labelOpacity: CGFloat = 0.85,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      DebugFrameModifier(
        label: text,
        labelOpacity: labelOpacity,
        colour: colour,
        isEnabled: isEnabled
      )
    )
  }
}
#endif
