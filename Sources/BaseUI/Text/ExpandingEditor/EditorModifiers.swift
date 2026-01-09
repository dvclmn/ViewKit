//
//  EditorView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/12/2025.
//

import SwiftUI


public struct EditorStylesModifier: ViewModifier {
  public init() {}
  public func body(content: Content) -> some View {
    content
      .padding(.horizontal, -5)
      .textEditorStyle(.plain)
      .scrollContentBackground(.hidden)

  }
}

/// Applied to the static Text views, which exist purely to provide the desired
/// Text View layout behaviour to the TextEditor view
public struct LayoutTextModifier: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .hidden()
      /// Note: Keep this frame, with maxWidth inifinity.
      /// Seems to work nicely.
      .frame(
        maxWidth: .infinity,
        alignment: .topLeading
      )
  }
}

/// Expanding Editor. Grows in height to fit preferred size for text content.
//
//public struct Editor {
//
//}

//
////extension Editor {
//  package struct BaseEditorPlainText: View {
//    @Binding var text: String
//
//    package init(_ text: Binding<String>) {
//      self._text = text
//    }
//
//    package var body: some View {
//
//      TextEditor(text: $text)
//        /// Removes the slight default padding, to better-match `Text`
//        .modifier(EditorStylesModifier())
//    }
//  }
////}
//
//@available(macOS 26, iOS 18, *)
////extension Editor {
//  package struct BaseEditorAttributed: View {
//    @Binding var text: AttributedString
//
//    package init(_ text: Binding<AttributedString>) {
//      self._text = text
//    }
//    package var body: some View {
//
//      TextEditor(text: $text)
//        /// Removes the slight default padding, to better-match `Text`
//        .modifier(EditorStylesModifier())
//
//    }
//  }
////}
