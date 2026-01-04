//
//  ExpandingBYOEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import SwiftUI

/// Editor namespace
@available(macOS 14.0, *)
public enum Editor<Content: View> {}

@available(macOS 14.0, *)
extension Editor.PlainText {
  public typealias Output = (Binding<String>) -> Content
}

@available(macOS 14.0, *)
extension Editor.Attributed {
  public typealias Output = (Binding<AttributedString>) -> Content
}

@available(macOS 14.0, *)
extension Editor {
  public struct PlainText: View {
    @Environment(\.textAlignment) private var textAlignment

    @Binding var text: String

    let alignment: Alignment
    let content: Output

    public init(
      _ text: Binding<String>,
      alignment: Alignment = .topLeading,
      @ViewBuilder content: @escaping Output = {
        TextEditor(text: $0)
          .modifier(EditorStylesModifier())
      }
    ) {
      self._text = text
      self.alignment = alignment
      self.content = content
    }

    public var body: some View {

      Text(text)  // This is for layout only
        .modifier(LayoutTextModifier())
        .overlay(alignment: .topLeading) { content($text) }
        .multilineTextAlignment(textAlignment ?? .leading)
    }
  }
}

@available(macOS 14.0, *)
extension Editor {
  public struct Attributed: View {
    @Environment(\.textAlignment) private var textAlignment

    @Binding var text: AttributedString

    let alignment: Alignment
    let content: Output

    public init(
      _ text: Binding<AttributedString>,
      alignment: Alignment = .topLeading,
      @ViewBuilder content: @escaping Output
    ) {
      self._text = text
      self.alignment = alignment
      self.content = content
    }

    public var body: some View {

      Text(text)  // This is for layout only
        .modifier(LayoutTextModifier())
        .overlay(alignment: .topLeading) { content($text) }
        .multilineTextAlignment(textAlignment ?? .leading)
    }
  }
}
