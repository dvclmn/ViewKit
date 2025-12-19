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
      
      Editor.PlainText($text)
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


/// This defaults to providing native `TextEditor`, not BYO Editor
//@available(macOS 14.0, *)
//public struct ExpandingEditor: View {
//  @Environment(\.textAlignment) private var textAlignment
//  @Binding var text: String
//  let alignment: Alignment
//
//  public init(
//    text: Binding<String>,
//    alignment: Alignment = .topLeading,
//  ) {
//    self._text = text
//    self.alignment = alignment
//  }
//  public var body: some View {
//    Editor.PlainText(
//      text: $text,
//      alignment: alignment
//    ) {
//      TextEditor(text: $0)
//    }
//
//  }
//}
//#if DEBUG
//@available(macOS 14.0, *)
//#Preview(traits: .size(.normal)) {
//  @Previewable @State var store = AppHandler()
//  ExampleView()
//    .environment(store)
//}
//#endif

