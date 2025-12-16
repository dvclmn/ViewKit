//
//  ExpandingTextEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import SwiftUI

@available(macOS 14.0, *)
public struct ExpandingTextEditor: View {
  @Environment(\.textAlignment) private var textAlignment

  //  @Binding var text: AttributedString?
  //  @Binding var plainText: String?
  private let attributedText: Binding<AttributedString>?
  private let plainText: Binding<String>?

  let alignment: Alignment

  public init(
    text: Binding<AttributedString>,
    alignment: Alignment = .topLeading,
  ) {
    self.attributedText = text
    self.plainText = nil
    self.alignment = alignment
  }

  public init(
    plainText: Binding<String>,
    alignment: Alignment = .topLeading,
  ) {
    self.attributedText = nil
    self.plainText = plainText
    self.alignment = alignment
  }

  public var body: some View {

    Group {
      if let attributedText {
        Text(attributedText.wrappedValue)
      } else if let plainText {
        Text(plainText.wrappedValue)
      } else {
        Text("No text found")
      }
    }
    .hidden()
    //    Text()

    /// Note: Keep this frame, with maxWidth inifinity.
    /// Seems to work nicely.
    .frame(
      maxWidth: .infinity,
      alignment: .topLeading
    )

    .overlay(alignment: .topLeading) {

      Group {
        if #available(macOS 26, iOS 18, *), let attributedText {
//          if let attributedText {
            TextEditor(text: attributedText)
//          } else {
//            Text("macOS 26+ but no attributedText")
//          }

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
    .multilineTextAlignment(textAlignment ?? .leading)
  }
}

@available(macOS 14.0, *)
extension ExpandingTextEditor {
  //  private var textBinding: Binding<String> {
  //    return Binding(
  //      get: {
  //        let text =
  //        String(self.plainText?.wrappedValue.characters)
  //      },
  //      set: { self.text = AttributedString($0) }
  //    )
  ////    return Binding {
  ////      self.text.toString
  ////    } set: { newValue in
  ////      self.text = newValue.toAttributed
  ////    }
  //
  //  }
}
