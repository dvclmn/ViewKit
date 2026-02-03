//
//  DebugTextOverlay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI

public struct DebugTextOverlayModifier: ViewModifier {
  @Environment(\.explicitColour) private var explicitColour

  @State private var gatheredText: String?

  let isEnabled: Bool
  let alignment: Alignment
  let padding: (Edge.Set, CGFloat?)

  public func body(content: Content) -> some View {
    content
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
            .background(explicitColour.withFallback(.clear).opacityLow)
            .clipShape(.rect(cornerRadius: 3))
            .padding()
            .safeAreaPadding(padding.0, padding.1)
            .allowsHitTesting(false)
        }
      }

      .onPreferenceChange(DebugTextKey.self) { newText in
        guard isEnabled else { return }
        //        debouncer.execute {
        handlePreferenceChange(newText)
        //        }

      }
  }
}

extension DebugTextOverlayModifier {

  private func handlePreferenceChange(_ newItems: DebugTextKey.Value) {

    self.gatheredText = newItems.joined(separator: "\n")
    /// Now this only runs when `newItems` actually changes
    //    let grouped = Dictionary(grouping: newItems, by: \.sectionKey)

    /// Group and Sort once
    //    self.sections = grouped.map { (key, items) in
    //      GroupedSection(id: key, title: key.title, items: items)
    //    }.sorted { $0.title < $1.title }

  }
}
//extension View {
//
//  /// Display any debug text provided in child views
//  public func displayDebugText(
//    isEnabled: Bool = true,
//    alignment: Alignment = .topLeading,
//    padding: (Edge.Set, CGFloat?) = (.all, nil)
//  ) -> some View {
//    self.modifier(
//      DebugTextOverlayModifier(
//        text: text.joined(separator: "\n"),
//        isEnabled: isEnabled,
//        alignment: alignment,
//        padding: padding
//      )
//    )
//  }
//}

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
        //        text: text.joined(separator: "\n"),
        isEnabled: isEnabled,
        alignment: alignment,
        padding: padding
      )
    )

  }

  //  public func debugTextOverlay(
  //    isEnabled: Bool = true,
  //    alignment: Alignment = .topLeading,
  //    padding: (Edge.Set, CGFloat?) = (.all, nil),
  //    displayString: () -> DisplayString
  //      //    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  //  ) -> some View {
  //    self.modifier(
  //      DebugTextOverlayModifier(
  //        text: displayString().text,
  //        isEnabled: isEnabled,
  //        alignment: alignment,
  //        padding: padding
  //      )
  //    )
  //  }
  //
  //  public func debugTextOverlay(
  //    isEnabled: Bool = true,
  //    alignment: Alignment = .topLeading,
  //    padding: (Edge.Set, CGFloat?) = (.all, nil),
  //    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  //  ) -> some View {
  //    self.modifier(
  //      DebugTextOverlayModifier(
  //        text: content().output(),
  //        isEnabled: isEnabled,
  //        alignment: alignment,
  //        padding: padding
  //      )
  //    )
  //  }
}
