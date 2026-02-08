//
//  DebugTextOverlay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI

public struct DebugTextOverlayModifier: ViewModifier {
  @Environment(\.colourOverride) private var colourOverride

  @State private var gatheredText: String?

  let isEnabled: Bool
  let alignment: Alignment
  let padding: (Edge.Set, CGFloat?)

  public func body(content: Content) -> some View {
    content
      .onPreferenceChange(DebugTextKey.self) { newText in
//        print("Running `DebugTextKey` `onPreferenceChange` at \(Date.debug)")
//        print("New text is: \(newText)")
        guard isEnabled else { return }
        self.gatheredText = newText.joined(separator: "\n")
      }
      .overlay(alignment: alignment) {
        if let gatheredText, isEnabled {
          Text(gatheredText)
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
            .background(colourOverride.withFallback(.clear).opacityLow)
            .clipShape(.rect(cornerRadius: 3))
            .padding()
            .safeAreaPadding(padding.0, padding.1)
            .allowsHitTesting(false)
        }
      }

  }
}

/// Maybe the below stay as the legacy version? Just need to work
/// out how to display or not display stuff
extension View {

  public func debugTextOverlay(
    //    _ text: String...,
    isEnabled: Bool = true,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, nil)
  ) -> some View {
    self.modifier(
      DebugTextOverlayModifier(
        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )
  }
}
