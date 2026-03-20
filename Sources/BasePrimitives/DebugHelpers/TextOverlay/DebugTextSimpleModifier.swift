//
//  DebugTextSimpleModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

public struct DebugTextSimpleOverlayModifier: ViewModifier {
  @Environment(\.colourOverride) private var colourOverride

  let text: String
  let isEnabled: Bool
  let alignment: Alignment
  let padding: (Edge.Set, CGFloat?)

  //  init(
  //    initialText: String?,
  //    isEnabled: Bool,
  //    alignment: Alignment,
  //    padding: (Edge.Set, CGFloat?)
  //  ) {
  //    self._initialText = State(initialValue: initialText)
  //    self.isEnabled = isEnabled
  //    self.alignment = alignment
  //    self.padding = padding
  //  }

  public func body(content: Content) -> some View {
    content
      //      .addDebugText(initialText ?? "")
      //      .onPreferenceChange(DebugTextKey.self) { newText in
      //        //        print("Running `DebugTextKey` `onPreferenceChange` at \(Date.debug)")
      //        //        print("New text is: \(newText)")
      //        guard isEnabled else { return }
      //        self.gatheredText = newText.joined(separator: "\n")
      //      }
      .overlay(alignment: alignment) {
        if isEnabled {
          Text(text)
            .fixedSize(horizontal: true, vertical: false)
            .font(.caption)
            .monospaced()
            .padding(Styles.sizeTiny)
            .background(.regularMaterial)
            //            .background(.black.opacityLow)

            //            .background(TintShapeStyle())
            .background(colourOverride?.opacityLow)
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
    _ text: String,
    isEnabled: Bool = true,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, Styles.sizeSmall)
  ) -> some View {
    self.modifier(
      DebugTextSimpleOverlayModifier(
        text: text,
        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )
  }

  public func debugTextOverlay(
    isEnabled: Bool = true,
    alignment: Alignment = .topLeading,
    padding: (Edge.Set, CGFloat?) = (.all, Styles.sizeSmall),
    @DisplayStringBuilder _ text: () -> [DisplayBlock]
  ) -> some View {
    self.modifier(
      DebugTextSimpleOverlayModifier(
        text: text().output(),
        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )
  }
}
