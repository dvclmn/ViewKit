//
//  EditorView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/12/2025.
//

import SwiftUI

/// Expanding Editor. Grows in height to fit preferred size for text content.
//@available(macOS 14.0, *)
//public struct Editor {
//
//}

//@available(macOS 14.0, *)
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

@available(macOS 14.0, *)
public struct EditorStylesModifier: ViewModifier {
  public init() {}
  public func body(content: Content) -> some View {
    content
      .padding(.horizontal, -5)
      .textEditorStyle(.plain)
      .scrollContentBackground(.hidden)
    
  }
}
