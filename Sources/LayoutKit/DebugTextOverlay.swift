//
//  DebugTextOverlay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/8/2025.
//

import CoreTools
import SwiftUI

public struct DebugTextOverlayModifier: ViewModifier {
  @Environment(\.isEnabled) private var isEnabled
  

  let text: String
//  let text: AttributedString
  let alignment: Alignment
  let padding: (Edge.Set, CGFloat?)
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        if isEnabled {
          Text(text)
            .fixedSize(horizontal: true, vertical: false)
            .font(.caption)
          //      .foregroundStyle(.primary.opacity(0.8))
            .monospaced()
          //      .monospacedDigit()
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(.regularMaterial)
//            .background(.black.opacityLow)
          
//            .background(TintShapeStyle())
            .background(.tint.opacityLow)
            .clipShape(.rect(cornerRadius: 3))
            .padding()
            .safeAreaPadding(padding.0, padding.1)
            .allowsHitTesting(false)
            
        }
      }
  }
}

extension View {

  public func debugTextOverlay(
    _ text: String...,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, nil)
  ) -> some View {
    self.modifier(
      DebugTextOverlayModifier(
        text: text.joined(separator: "\n"),
        alignment: alignment,
        padding: padding
      )
    )
  }
  
  public func debugTextOverlay(
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, nil),
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) -> some View {
    self.modifier(
      DebugTextOverlayModifier(
        text: content().output(),
        alignment: alignment,
        padding: padding
      )
    )
  }
}
