//
//  ExpandingTextEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import SwiftUI

//@available(macOS 14.0, *)
//public struct ExpandingTextEditor: View {
//  @Environment(\.textAlignment) private var textAlignment
//
//  private let attributedText: Binding<AttributedString>?
//  private let plainText: Binding<String>?
//
//  let alignment: Alignment
//
//  public init(
//    text: Binding<AttributedString>,
//    alignment: Alignment = .topLeading,
//  ) {
//    self.attributedText = text
//    self.plainText = nil
//    self.alignment = alignment
//  }
//
//  public init(
//    plainText: Binding<String>,
//    alignment: Alignment = .topLeading,
//  ) {
//    self.attributedText = nil
//    self.plainText = plainText
//    self.alignment = alignment
//  }
//
//  public var body: some View {
//
//    TextForLayout(attributed: attributedText, plain: plainText)
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
