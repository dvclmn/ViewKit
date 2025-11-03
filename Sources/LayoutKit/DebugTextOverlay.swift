//
//  DebugTextOverlay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI
import StringShared

public struct DebugTextOverlayModifier: ViewModifier {
  @Environment(\.isEnabled) private var isEnabled
  
  let text: AttributedString
//  let isEnabled: Bool
  let alignment: Alignment
  let padding: (Edge.Set, CGFloat?)
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        if isEnabled {
          Text(text)
            .modifier(DebugTextStyleModifier())
            .safeAreaPadding(padding.0, padding.1)
            .allowsHitTesting(false)
        }
      }
  }
}

public struct DebugTextStyleModifier: ViewModifier {

  public func body(content: Content) -> some View {
    content
      .fixedSize(horizontal: true, vertical: false)
      .font(.caption)
      //      .foregroundStyle(.primary.opacity(0.8))
      .monospaced()
      //      .monospacedDigit()
      .padding(.horizontal, 6)
      .padding(.vertical, 4)
      .background(.regularMaterial)
      .background(.black.opacityLow)
      .clipShape(.rect(cornerRadius: 3))
      .padding()
  }
}

extension View {

  //  public func debugTextOverlay(
  //    _ text: String,
  //    isEnabled: Bool = true,
  //    alignment: Alignment = .topLeading,
  //    padding: (Edge.Set, CGFloat?) = (.all, nil)
  //  ) -> some View {
  //    self.modifier(
  //      DebugTextOverlayModifier(
  //        text: AttributedString(text),
  //        isEnabled: isEnabled,
  //        alignment: alignment,
  //        padding: padding
  //      )
  //    )
  //  }

  public func debugTextOverlay(
    _ text: AttributedString,
//    isEnabled: Bool = true,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, nil)
  ) -> some View {
    self.modifier(
      DebugTextOverlayModifier(
        text: text,
//        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )
  }

  public func debugTextOverlay(
    _ text: String...,
    isEnabled: Bool = true,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, nil)
  ) -> some View {
    self.modifier(
      DebugTextOverlayModifier(
        text: AttributedString(text.joined(separator: "\n")),
        //        value: value.flatMap().joined(separator: "\n"),
//        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )
  }
  
  public func debugTextOverlay(
//    _ text: String...,
    isEnabled: Bool = true,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, nil),
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) -> some View {
    self.modifier(
      DebugTextOverlayModifier(
        text: content().styledOutput(),
        //        value: value.flatMap().joined(separator: "\n"),
//        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )
  }
}
