//
//  EditorView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/12/2025.
//

import SwiftUI

public struct Editor {
  
}

@available(macOS 14.0, *)
package struct EditorView: View {
  //  @Environment(AppHandler.self) private var store

  private let attributedText: Binding<AttributedString>?
  private let plainText: Binding<String>?

  package init(
    attributed: Binding<AttributedString>?,
    plain: Binding<String>?
  ) {
    self.attributedText = attributed
    self.plainText = plain
  }

  package var body: some View {

    Group {
      if #available(macOS 26, iOS 18, *), let attributedText {
        TextEditor(text: attributedText)

      } else if let plainText {
        TextEditor(text: plainText)

      } else if let attributedText {

        /// Bridging: fallback for older platforms (lossy)
        TextEditor(
          text: Binding(
            get: { String(attributedText.wrappedValue.characters) },
            set: { attributedText.wrappedValue = AttributedString($0) }
          ))
      } else {
        Text("No text found")
      }
    }

    /// Removes the slight default padding, to better-match `Text`
    .padding(.horizontal, -5)
    .textEditorStyle(.plain)

  }
}
