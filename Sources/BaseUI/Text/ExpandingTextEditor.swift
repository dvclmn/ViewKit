//
//  ExpandingTextEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import SwiftUI

public struct ExpandingTextEditor<Content: View>: View {
  
  @Binding var text: String
  let alignment: Alignment
  let content: Content
  
  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content()
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
        content
        
        TextEditor(text: $text)
//          .focused($focused, equals: .textField(cellPosition))
//          .scrollDisabled(true)
        /// Removes the slight default padding, to better-match `Text`
          .padding(.horizontal, -5)
          .textEditorStyle(.plain)

      }
      .multilineTextAlignment(textAlignment)
  }
}
