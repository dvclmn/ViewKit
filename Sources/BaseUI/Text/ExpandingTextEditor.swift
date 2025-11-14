//
//  ExpandingTextEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import SwiftUI

public struct ExpandingTextEditor: View {
  @Environment(\.textAlignment) private var textAlignment
  
  @Binding var text: String
  let alignment: Alignment
  
  public init(
    text: Binding<String>,
    alignment: Alignment = .topLeading,
  ) {
    self._text = text
    self.alignment = alignment
  }
  
  public var body: some View {
    
    Text(text)
      .hidden()
    
    /// Note: Keep this frame, with maxWidth inifinity.
    /// Seems to work nicely.
      .frame(
        maxWidth: .infinity,
        alignment: .topLeading
      )
    
      .overlay(alignment: .topLeading) {
        TextEditor(text: $text)
        /// Removes the slight default padding, to better-match `Text`
          .padding(.horizontal, -5)
          .textEditorStyle(.plain)

      }
      .multilineTextAlignment(textAlignment ?? .leading)
  }
}
