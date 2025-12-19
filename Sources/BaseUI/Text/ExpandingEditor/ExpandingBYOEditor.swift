//
//  ExpandingBYOEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

//@available(macOS 14.0, *)
///// BYO Editor
//public struct ExpandingEditor<Content: View>: View {
//  @Environment(\.textAlignment) private var textAlignment
//  
////  private let attributedText: Binding<AttributedString>?
////  private let plainText: Binding<String>?
//  
//  let alignment: Alignment
//  let content: Content
//  
//  public init(
////    text: Binding<String>,
//    alignment: Alignment = .topLeading,
//    @ViewBuilder content: @escaping () -> Content
//  ) {
////    self.plainText = nil
//    self.alignment = alignment
//  }
//  
//  public var body: some View {
//    
//    TextForLayout(attributed: nil, plain: plainText)
//      .overlay(alignment: .topLeading) {
//        EditorView(attributed: attributedText, plain: plainText)
//      }
//      .multilineTextAlignment(textAlignment ?? .leading)
//  }
//}
//
//@available(macOS 14.0, *)
//extension ExpandingTextEditor {
//  //  private var textBinding: Binding<String> {
//  //    return Binding(
//  //      get: {
//  //        let text =
//  //        String(self.plainText?.wrappedValue.characters)
//  //      },
//  //      set: { self.text = AttributedString($0) }
//  //    )
//  ////    return Binding {
//  ////      self.text.toString
//  ////    } set: { newValue in
//  ////      self.text = newValue.toAttributed
//  ////    }
//  //
//  //  }
//}
