//
//  ExampleEditorView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import CoreTools
import SwiftUI



@available(macOS 14.0, *)
struct ExpandingEditorExampleView: View {
  @State private var text: String = DummyContent.Strings.loremIpsum
  var body: some View {
    
    VStack {
      TextEditor(text: $text)
        .scrollContentBackground(.hidden)
        .background(.brown.tertiary)

      ExpandingTextEditor(plainText: $text)
        .background(.purple.tertiary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

  }
}
#if DEBUG
@available(macOS 14.0, *)
#Preview(traits: .size(.normal)) {
  ExpandingEditorExampleView()
}
#endif
